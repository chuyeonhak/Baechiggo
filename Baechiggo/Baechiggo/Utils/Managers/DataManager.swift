//
//  DataManager.swift
//  Baechiggo
//
//  Created by chuchu on 1/9/24.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private init() { setNameDictionary() }
    var nameDictionary: [String: String] = [:]
    
    private func setNameDictionary() {
        Task {
            guard let data = try await NetworkManager.shared.requestAPI(.getUserDatabase),
                  let json = try? JSONDecoder().decode(NotionData.self, from: data)
            else { return }
            
            self.nameDictionary = json.results.reduce(into: [:]) { result, info in
                result[info.idString] = info.koreanName
            }
            
            print(nameDictionary)
        }
        
    }
}
