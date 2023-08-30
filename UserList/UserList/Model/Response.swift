//
//  Response.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 30/8/2023.
//

struct Item: Codable {
    var login: String
    var avatar_url: String
    var html_url: String
    var url: String
    var bio: String?
    var followers_url: String
    var followers: Int?
    var following: Int?
    var public_repos: Int?
}

struct Response: Codable {
    var items: [Item]
}

