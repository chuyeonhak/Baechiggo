//
//  Sequence +.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
    
    func asyncCompactMap<T>(
        _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            guard let value = try await transform(element) else { continue }
            values.append(value)
        }
        
        return values
    }
}
