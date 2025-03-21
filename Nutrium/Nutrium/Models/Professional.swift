//
//  Professional.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

import Foundation

struct Professional: Codable, Equatable {
    let expertise: [String]
    let id: Int
    let languages: [String]
    let name: String
    let profilePictureUrl: String
    let rating: Int
    let ratingCount: Int
    var aboutMe: String?
    
    enum CodingKeys: String, CodingKey {
        case expertise, id, languages, name, rating
        case profilePictureUrl = "profile_picture_url"
        case ratingCount = "rating_count"
        case aboutMe = "about_me"
    }
}
