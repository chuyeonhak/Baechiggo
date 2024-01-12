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
        case matchData(String)
        case getAllUser
        case queryDataBase(String)
        case getUserDatabase
        
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
            case .matchData(let id):
                return domain + "blocks/\(id)/children"
            case .getAllUser:
                return domain + "users"
            case .queryDataBase(let id):
                return domain + "databases/\(id)/query"
            case .getUserDatabase:
                return domain + "databases/\(KeyManager.shared.getKey(.userDatabaseID))/query"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .matchDataList, .matchData(_), .getAllUser: return .get
            case .queryDataBase(_), .getUserDatabase: return .post
            }
        }
        
        var parameters: Parameters? { nil }
        
        var parameterEncoding: ParameterEncoding {
            return JSONEncoding.default
        }
    }
}
