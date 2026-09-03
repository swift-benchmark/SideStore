{
  "rootDir": "SideStore",
  "specs": [
    {
      "language": "swift",
      "rule": "CWE-601",
      "sink": {
        "fqn": "PL::SideStore/DeepLinks/ExportCertificateDialog.swift::50",
        "line": 50
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::AltStore/SceneDelegate.swift::93",
          "line": 93
        },
        {
          "fqn": "PL::AltStore/SceneDelegate.swift::140",
          "line": 140
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::87",
          "line": 87
        },
        {
          "fqn": "PL::SideStore/DeepLinks/ExportCertificateDialog.swift::38",
          "line": 38
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::AltStore/SceneDelegate.swift::91",
          "line": 91
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-943",
      "sink": {
        "fqn": "PL::AltStore/Core/Roxas/NSPredicate+Search.swift::66",
        "line": 66
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::98",
          "line": 98
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::184",
          "line": 184
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::192",
          "line": 192
        },
        {
          "fqn": "PL::AltStore/Core/Roxas/NSPredicate+Search.swift::62",
          "line": 62
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::95",
          "line": 95
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-22",
      "sink": {
        "fqn": "PL::SideStore/Core/Anisette/AnisetteServersManager.swift::276",
        "line": 276
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::109",
          "line": 109
        },
        {
          "fqn": "PL::SideStore/Core/Anisette/AnisetteServersManager.swift::272",
          "line": 272
        },
        {
          "fqn": "PL::SideStore/Core/Anisette/AnisetteServersManager.swift::273",
          "line": 273
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::106",
          "line": 106
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-918",
      "sink": {
        "fqn": "PL::SideStore/Core/Anisette/AnisetteServersManager.swift::293",
        "line": 293
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::120",
          "line": 120
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::197",
          "line": 197
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::200",
          "line": 200
        },
        {
          "fqn": "PL::SideStore/Core/Anisette/AnisetteServersManager.swift::284",
          "line": 284
        },
        {
          "fqn": "PL::SideStore/Core/Anisette/AnisetteServersManager.swift::288",
          "line": 288
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::117",
          "line": 117
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-79",
      "sink": {
        "fqn": "PL::AltStore/Core/Components/WebViewController.swift::185",
        "line": 185
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::132",
          "line": 132
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::213",
          "line": 213
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::217",
          "line": 217
        },
        {
          "fqn": "PL::AltStore/Core/Components/WebViewController.swift::178",
          "line": 178
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::128",
          "line": 128
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-338",
      "sink": {
        "fqn": "PL::SideStore/Utils/importexport/ImportExport.swift::173",
        "line": 173
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/Utils/importexport/ImportExport.swift::160",
          "line": 160
        },
        {
          "fqn": "PL::SideStore/Utils/importexport/ImportExport.swift::162",
          "line": 162
        },
        {
          "fqn": "PL::SideStore/Utils/importexport/ImportExport.swift::170",
          "line": 170
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/Utils/importexport/ImportExport.swift::158",
          "line": 158
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-321",
      "sink": {
        "fqn": "PL::SideStore/Utils/importexport/ImportExport.swift::142",
        "line": 142
      },
      "codeFlowLocations": [],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": []
    },
    {
      "language": "swift",
      "rule": "CWE-134",
      "sink": {
        "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::248",
        "line": 248
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::160",
          "line": 160
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::244",
          "line": 244
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::245",
          "line": 245
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::156",
          "line": 156
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-117",
      "sink": {
        "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::259",
        "line": 259
      },
      "codeFlowLocations": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::172",
          "line": 172
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::255",
          "line": 255
        },
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::256",
          "line": 256
        }
      ],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/DeepLinks/URLHandler.swift::169",
          "line": 169
        }
      ]
    }
  ],
  "unsupported_cwes": [
    {
      "language": "swift",
      "rule": "CWE-319",
      "sink": {
        "fqn": "PL::SideStore/Core/Operations/PipelineOperations/EnableJITOperation.swift::45",
        "line": 45
      },
      "codeFlowLocations": [],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/Core/Operations/PipelineOperations/EnableJITOperation.swift::45",
          "line": 45
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-73",
      "sink": {
        "fqn": "PL::SideStore/Core/Operations/PipelineOperations/CacheAppOperation.swift::30",
        "line": 30
      },
      "codeFlowLocations": [],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/Core/Operations/PipelineOperations/CacheAppOperation.swift::30",
          "line": 30
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-73",
      "sink": {
        "fqn": "PL::SideStore/Core/Operations/PipelineOperations/ResignAppOperation.swift::51",
        "line": 51
      },
      "codeFlowLocations": [],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/Core/Operations/PipelineOperations/ResignAppOperation.swift::51",
          "line": 51
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-73",
      "sink": {
        "fqn": "PL::SideStore/Core/Operations/PipelineOperations/ExportResignedAppOperation.swift::57",
        "line": 57
      },
      "codeFlowLocations": [],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/Core/Operations/PipelineOperations/ExportResignedAppOperation.swift::57",
          "line": 57
        }
      ]
    },
    {
      "language": "swift",
      "rule": "CWE-73",
      "sink": {
        "fqn": "PL::SideStore/Core/Operations/StandaloneOperations/DownloadAppOperation.swift::266",
        "line": 266
      },
      "codeFlowLocations": [],
      "vulnerable": true,
      "currentlySignaled": true,
      "technologies": [],
      "comments": [],
      "reviewResults": [],
      "sourcesWhenGeneratedFromSarif": [
        {
          "fqn": "PL::SideStore/Core/Operations/StandaloneOperations/DownloadAppOperation.swift::266",
          "line": 266
        }
      ]
    }
  ]
}