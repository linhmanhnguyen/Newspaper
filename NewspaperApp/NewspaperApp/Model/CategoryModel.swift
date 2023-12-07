//
//  CategoryModel.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 26/11/2023.
//

import Foundation

struct CategoryModel: Codable {
    var IDCategory: Int
    var nameCategory: String
    
    enum CodingKeys: String, CodingKey {
        case IDCategory = "IDCategory"
        case nameCategory = "nameCategory"
    }
}

typealias Category = [CategoryModel]
