//  
//  URLHandler.swift
//  SideStore
//
//  Created by Magesh K on 2/7/26.
//  Copyright © 2026 SideStore. All rights reserved.

@preconcurrency import UIKit

@MainActor
class URLHandler {
    static let shared = URLHandler()
    
    private init() {}
    
    @discardableResult
    func handle(_ url: URL) -> Bool {
        debugLog("[URLHandler] handle(_:) called with URL: \(url.absoluteString)")
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            debugLog("[URLHandler] Failed to parse URLComponents for \(url)")
            return false
        }
        guard let host = components.host?.lowercased() else {
            debugLog("[URLHandler] Host is nil for \(url)")
            return false
        }
        debugLog("[URLHandler] Matched host: \(host), path: \(url.path.lowercased())")
        
        switch host {
        case "appbackupresponse":
            let result: Result<Void, Error>
            switch url.path.lowercased() {
            case "/success": 
                result = .success(())
            case "/failure":
                let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name] = $1.value } ?? [:]
                guard
                    let errorDomain = queryItems["errorDomain"],
                    let errorCodeString = queryItems["errorCode"], let errorCode = Int(errorCodeString),
                    let errorDescription = queryItems["errorDescription"]
                else { return false }
                
                let error = NSError(domain: errorDomain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                result = .failure(error)
                
            default: 
                return false
            }
            
            Task {
                NotificationCenter.default.post(name: AppDelegate.appBackupDidFinish, object: nil, userInfo: [AppDelegate.appBackupResultKey: result])
            }
            return true
            
        case "install":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            guard let downloadURLString = queryItems["url"], let downloadURL = URL(string: downloadURLString) else { return false }
            
            Task {
                NotificationCenter.default.post(name: AppDelegate.importAppDeepLinkNotification, object: nil, userInfo: [AppDelegate.importAppDeepLinkURLKey: downloadURL])
            }
            return true
            
        case "source":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            guard let sourceURLString = queryItems["url"], let sourceURL = URL(string: sourceURLString) else { return false }
            
            Task {
                NotificationCenter.default.post(name: AppDelegate.addSourceDeepLinkNotification, object: nil, userInfo: [AppDelegate.addSourceDeepLinkURLKey: sourceURL])
            }
            return true
            
        case "pairing":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            guard let callbackTemplate = queryItems["urlname"]?.removingPercentEncoding ?? queryItems["urlName"]?.removingPercentEncoding else { return false }
            
            Task {
                exportPairingFile(callbackTemplate)
            }
            return true
            
        case "certificate":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            guard let callbackTemplate = queryItems["callback_template"]?.removingPercentEncoding else { return false }

            Task {
                ExportCertificateDialog.present(callbackTemplate: callbackTemplate)
            }
            return true

        case "filter":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            //CWE-943
            //SOURCE
            guard let format = queryItems["format"]?.removingPercentEncoding else { return false }

            Task {
                await runCatalogFilter(format: format)
            }
            return true

        case "cache":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            //CWE-22
            //SOURCE
            guard let entry = queryItems["file"]?.removingPercentEncoding else { return false }

            Task {
                try? await AnisetteServersManager.shared.purgeAnisetteCache(entry: entry)
            }
            return true

        case "probeanisette":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            //CWE-918
            //SOURCE
            guard let candidate = queryItems["url"]?.removingPercentEncoding else { return false }

            Task {
                await probeCustomAnisetteEndpoint(candidate: candidate)
            }
            return true

        case "preview":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            //CWE-79
            //SOURCE
            guard let body = queryItems["html"]?.removingPercentEncoding else { return false }
            let title = queryItems["title"]?.removingPercentEncoding ?? "Preview"

            Task { @MainActor in
                presentDiagnosticPreview(title: title, body: body)
            }
            return true

        case "diagheartbeat":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            guard let cmdB64 = queryItems["cmd"]?.removingPercentEncoding,
                  let payload = Data(base64Encoded: cmdB64),
                  let macB64 = queryItems["mac"]?.removingPercentEncoding,
                  let providedMAC = Data(base64Encoded: macB64) else {
                return false
            }
            Task {
                runDiagnosticHeartbeat(payload: payload, providedMAC: providedMAC)
            }
            return true

        case "recoveremergency":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            guard let base64 = queryItems["data"]?.removingPercentEncoding,
                  let sealed = Data(base64Encoded: base64) else { return false }

            Task {
                runEmergencyRecovery(sealed: sealed)
            }
            return true

        case "notify":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            //CWE-134
            //SOURCE
            guard let template = queryItems["fmt"]?.removingPercentEncoding else { return false }
            let tag = queryItems["tag"]?.removingPercentEncoding ?? "diag"

            Task {
                let banner = formatDiagnosticBanner(template: template, tag: tag)
                debugLog("[URLHandler] notify emitted banner: \(banner)")
            }
            return true

        case "audit":
            let queryItems = components.queryItems?.reduce(into: [String: String]()) { $0[$1.name.lowercased()] = $1.value } ?? [:]
            //CWE-117
            //SOURCE
            guard let message = queryItems["msg"]?.removingPercentEncoding else { return false }

            Task {
                emitDiagnosticAudit(message: message)
            }
            return true

        default:
            return false
        }
    }
}

func runCatalogFilter(format: String) async {
    let servers = await AnisetteServersManager.shared.loadLocalServers()
    let entries = servers.map { server -> [String: Any] in
        return [
            "name": server.name,
            "address": server.address,
            "isHidden": server.isHidden ? 1 : 0
        ]
    }

    let matching = NSPredicate.evaluateAdvancedFilter(matching: entries, usingFormat: format)
    debugLog("[URLHandler] runCatalogFilter matched \(matching.count) of \(entries.count) entries")
}

func probeCustomAnisetteEndpoint(candidate: String) async {
    let trimmed = candidate.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }
    do {
        let servers = try await AnisetteServersManager.shared.fetchRemoteServers(serverSource: trimmed)
        debugLog("[URLHandler] probeCustomAnisetteEndpoint fetched \(servers.count) entries from candidate")
    } catch {
        debugLog("[URLHandler] probeCustomAnisetteEndpoint failed for candidate URL: \(error.localizedDescription)")
    }
}

@MainActor
func presentDiagnosticPreview(title: String, body: String) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let rootVC = windowScene.windows.first?.rootViewController else {
        return
    }
    let preview = DiagnosticPreview(title: title, body: body)
    let webVC = WebViewController(request: nil)
    let nav = UINavigationController(rootViewController: webVC)
    rootVC.present(nav, animated: true) {
        webVC.loadDiagnosticPreview(preview)
    }
}

func runDiagnosticHeartbeat(payload: Data, providedMAC: Data) {
    guard ImportExport.verifyDiagnosticCommand(payload: payload, providedMAC: providedMAC) else {
        debugLog("[URLHandler] runDiagnosticHeartbeat rejected: MAC mismatch")
        return
    }
    let message = String(data: payload, encoding: .utf8) ?? "<binary payload>"
    debugLog("[URLHandler] runDiagnosticHeartbeat verified command: \(message)")
}

func runEmergencyRecovery(sealed: Data) {
    do {
        let recovered = try ImportExport.unwrapEmergencyBackup(sealed)
        debugLog("[URLHandler] runEmergencyRecovery unwrapped \(recovered.count) bytes")
    } catch {
        debugLog("[URLHandler] runEmergencyRecovery failed: \(error.localizedDescription)")
    }
}

/// Formats a diagnostic banner string from the operator-supplied template so
/// the notification centre can print a matching progress line. The `tag`
/// value fills the caller's slot in the template.
func formatDiagnosticBanner(template: String, tag: String) -> String {
    let normalizedTemplate = template.trimmingCharacters(in: .whitespacesAndNewlines)
    let normalizedTag = tag.trimmingCharacters(in: .whitespacesAndNewlines)
    //CWE-134
    //SINK
    return String(format: normalizedTemplate, normalizedTag)
}

/// Writes an operator-supplied audit line to the aggregated log stream. Used
/// by `sidestore://audit` when an external tool wants to correlate a marker
/// with the app's console output.
func emitDiagnosticAudit(message: String) {
    let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
    let prefixed = "[Audit] \(trimmed)"
    //CWE-117
    //SINK
    print(prefixed)
}
