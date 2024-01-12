//
//  NotionData.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import Foundation

struct NotionData: Codable, Identifiable {
    let id = UUID()
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
    let childPage: Child?
    let type: String?
    let paragraph: Paragraph?
    let childDatabase: Child?
    let properties: Properties?
    let imageUrl: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdTime = "created_time"
        case lastEditedTime = "last_edited_time"
        case hasChildren = "has_children"
        case archived
        case childPage = "child_page"
        case type, paragraph
        case childDatabase = "child_database"
        case properties
        case imageUrl = "avatar_url"
        case name
    }
    
    static func == (lhs: NotionInfo, rhs: NotionInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Child: Codable {
    let title: String?
}

enum UserType: String, Codable {
    case bot = "bot"
    case person = "person"
}

struct Paragraph: Codable {
    let richText: [String]?
    let color: String?
    
    enum CodingKeys: String, CodingKey {
        case richText = "rich_text"
        case color
    }
}

struct Properties: Codable {
    let win: Win?
    let name: NameData?
    let team진우, team새롬: Team?
    
    enum CodingKeys: String, CodingKey {
        case win = "승"
        case name = "이름"
        case team진우 = "TEAM 진우"
        case team새롬 = "TEAM 새롬"
    }
}

struct Team: Codable {
    let id, type: String?
    let relation: [Relation]?
    let hasMore: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case id, type, relation
        case hasMore = "has_more"
    }
}

struct Relation: Codable {
    let id: String?
    
    var name: String { DataManager.shared.nameDictionary[id ?? ""] ?? "" }
}

struct Win: Codable {
    let id, type: String?
    let select: Select?
}

// MARK: - Select
struct Select: Codable {
    let id, name, color: String?
}

struct NameData: Codable {
    let title: [RichText]?
}

struct RichText: Codable {
    let plainText: String?
    
    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
}


extension NotionInfo {
    var idString: String { id ?? "" }
    
    var titleString: String { childPage?.title ?? "" }
    
    var isPerson: Bool { type == "person" }
    
    var koreanName: String { properties?.name?.title?.first?.plainText ?? "" }
    
    var isDatabase: Bool { childDatabase != nil }
}
