//
//  Photo.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let description: String?
    let alt_description: String?
    let color: String
    let likes: Int
    let urls: Urls
    let user: User

    var displayDescription: String {
        description ?? alt_description ?? "No Description"
    }
}

struct Urls: Decodable {
    let thumb: String
    let regular: String
}

struct User: Decodable {
    let username: String
}
