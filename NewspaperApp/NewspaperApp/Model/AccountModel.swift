//
//  AccountModel.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 02/08/2023.
//

import Foundation

struct AccountModel: Codable {
    var account_id: Int
    var email: String
    var IDUser: Int
    var password_of_user: String
    var status: String
    
    init(account_id: Int, email: String, IDUser: Int, password_of_user: String, status: String) {
        self.account_id = account_id
        self.email = email
        self.IDUser = IDUser
        self.password_of_user = password_of_user
        self.status = status
    }
}
typealias AccountTypelias = [AccountModel]
