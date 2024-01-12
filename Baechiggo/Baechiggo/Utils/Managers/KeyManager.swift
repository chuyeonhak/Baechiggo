//
//  KeyManager.swift
//  Baechiggo
//
//  Created by chuchu on 1/5/24.
//

import Foundation

struct KeyManager {
    static let shared = KeyManager()
    
    private init() { }
    
    func getKey(_ type: KeyType) -> String {
        guard let keyListPath = Bundle.main.path(forResource: "KeyList", ofType: "plist"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: keyListPath)),
              let keyList = try? PropertyListSerialization.propertyList(
                from: data,
                options: .mutableContainers,
                format: nil) as? [String: Any],
              let value = keyList[type.key] as? String
        else { return "" }
        
        return value
    }
}

extension KeyManager {
    enum KeyType {
        case notionSecretKey
        case matchListBlockID
        case userDatabaseID
        
        var key: String {
            switch self {
            case .notionSecretKey:
                "NotionSecretKey"
            case .matchListBlockID:
                "MatchListBlockID"
            case .userDatabaseID:
                "UserDatabaseID"
            }
        }
    }
}
