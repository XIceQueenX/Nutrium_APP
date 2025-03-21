//
//  FiveStarsRating.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Int
    let width: CGFloat
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .scaledToFit()
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(.yellow)
            }
        }
        .frame(width: width)
    }
    
    private var starSize: CGFloat {
        return width / 5
    }
}

#Preview {
    VStack {
        StarRatingView(rating: 3, width: 100)
    }
}


