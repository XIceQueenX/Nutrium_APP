//
//  ProfessionalResponse.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

struct ProfessionalResponse: Codable {
    let count: Int
    let limit: Int
    let offset: Int
    let professionals: [Professional]
}
