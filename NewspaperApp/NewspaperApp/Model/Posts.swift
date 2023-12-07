//
//  Posts.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 03/12/2023.
//

import Foundation

struct PostsModel: Codable {
    var id: Int
    var avatar: String
    var title: String
    var content: String
    var category: String

    init(id: Int, avatar: String, title: String, content: String, category: String) {
        self.id = id
        self.avatar = avatar
        self.title = title
        self.content = content
        self.category = category
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case avatar = "avatar"
        case title = "title"
        case content = "content"
        case category = "category"
    }
    
}

typealias Posts = [PostsModel]
