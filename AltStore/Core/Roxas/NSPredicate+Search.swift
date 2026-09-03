//
//  NSPredicate+Search.swift
//  AltStore
//
//  Created by Magesh K on 6/17/26.
//

import Foundation

public extension NSPredicate {
    @objc(predicateForSearchingForText:inValuesForKeyPaths:)
    static func forSearching(forText searchText: String, inValuesForKeyPaths keyPaths: Set<String>) -> NSPredicate {
        if keyPaths.isEmpty {
            return NSPredicate(value: false)
        }
        
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        
        let strippedString = searchText.trimmingCharacters(in: .whitespaces)
        let searchTerms = strippedString.components(separatedBy: .whitespacesAndNewlines)
        
        var subpredicates = [NSPredicate]()
        
        for searchTerm in searchTerms {
            var orPredicates = [NSPredicate]()
            
            for keyPath in keyPaths {
                let lhs = NSExpression(forKeyPath: keyPath)
                let rhs = NSExpression(forConstantValue: searchTerm)
                
                let predicate = NSComparisonPredicate(
                    leftExpression: lhs,
                    rightExpression: rhs,
                    modifier: .direct,
                    type: .contains,
                    options: [.caseInsensitive, .diacriticInsensitive]
                )
                
                orPredicates.append(predicate)
            }
            
            let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: orPredicates)
            subpredicates.append(compoundPredicate)
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: subpredicates)
    }

    /// Applies an operator-supplied filter expression against a catalog listing
    /// so a diagnostic caller can slice the visible entries by an ad-hoc rule
    /// (e.g. `address BEGINSWITH 'https://'` or `isHidden == 0`). Returns the
    /// matching entries unchanged; an empty/whitespace expression leaves the
    /// listing untouched.
    static func evaluateAdvancedFilter(
        matching entries: [[String: Any]],
        usingFormat format: String
    ) -> [[String: Any]] {
        let trimmed = format.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return entries }
        let predicate = NSPredicate(format: trimmed)
        return entries.filter { entry in
            //CWE-943
            //SINK
            predicate.evaluate(with: entry as NSDictionary)
        }
    }
}
