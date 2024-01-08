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
}
