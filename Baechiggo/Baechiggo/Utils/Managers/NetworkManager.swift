//
//  NetworkManager.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import Foundation
import Alamofire

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    private let notionHeaders : HTTPHeaders = [
        HTTPHeader(name: "Authorization", value: KeyManager.shared.getKey(.notionSecretKey)),
        HTTPHeader(name: "Notion-Version", value: "2022-06-28")
    ]
    
    func requestAPI(_ type: NetworkType, completion: @escaping (AFDataResponse<Data?>) -> ()) {
        AF.request(type.urlString,
                   method: type.method,
                   parameters: type.parameters,
                   encoding: type.parameterEncoding,
                   headers: type.header)
        .validate(statusCode: 200..<600)
        .response(completionHandler: completion)
    }
    
    func requestAPI(_ type: NetworkType) async throws -> Data? {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(type.urlString,
                       method: type.method,
                       parameters: type.parameters,
                       encoding: type.parameterEncoding,
                       headers: type.header)
            .validate(statusCode: 200..<600)
            .response { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
