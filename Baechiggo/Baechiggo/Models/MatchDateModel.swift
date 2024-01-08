//
//  MatchDateModel.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import Foundation

struct MatchDateModel: Codable {
    let matchDateList: [MatchDate]
    let hasMore: Bool?

    enum CodingKeys: String, CodingKey {
        case matchDateList = "results"
        case hasMore = "has_more"
    }
}

struct MatchDate: Codable, Hashable {
    static func == (lhs: MatchDate, rhs: MatchDate) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
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
}

// MARK: - ChildPage
struct ChildPage: Codable {
    let title: String?
}
