//
//  MatchDateModel.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import Foundation

struct MatchDateModel: Codable {
    let results: [NotionInfo]
    let hasMore: Bool?

    enum CodingKeys: String, CodingKey {
        case results
        case hasMore = "has_more"
    }
}

struct NotionInfo: Codable, Hashable {
    let id: String?
    let createdTime, lastEditedTime: String?
    let hasChildren, archived: Bool?
    let childPage: ChildPage?

    enum CodingKeys: String, CodingKey {
        case id
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case hasChildren = "has_children"
        case archived
        case childPage = "child_page"
    }
    
    static func == (lhs: NotionInfo, rhs: NotionInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ChildPage: Codable {
    let title: String?
}

extension NotionInfo {
    var idString: String { id ?? "" }
    
    var titleString: String { childPage?.title ?? "" }
}
