//
//  Utils.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

import Foundation

func downloadImage(from urlString: String) async -> Data? {
    do {
        let data =  try await API.shared.session.request(urlString)
            .serializingData()
            .value
        return data
    } catch {
        print("Failed downloadImage \(urlString): \(error.localizedDescription)")
        return nil
    }
}

  
