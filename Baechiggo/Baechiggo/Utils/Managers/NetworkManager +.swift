//
//  NetworkManager +.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import Foundation
import Alamofire

extension NetworkManager {
    enum NetworkType {
        case matchDataList
        case getAllUser
        
        var header: HTTPHeaders {
            return [
                HTTPHeader(name: "Authorization", value: KeyManager.shared.getKey(.notionSecretKey)),
                HTTPHeader(name: "Notion-Version", value: "2022-06-28")
            ]
        }
        
        var urlString: String {
            let domain = "https://api.notion.com/v1/"
            switch self {
            case .matchDataList:
                return domain + "blocks/\(KeyManager.shared.getKey(.matchListBlockID))/children"
            case .getAllUser:
                return domain + "users"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .matchDataList:
                return .get
            case .getAllUser:
                return .get
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case .matchDataList, .getAllUser: nil
            }
        }
        
        var parameterEncoding: ParameterEncoding {
            return JSONEncoding.default
        }
    }
}
