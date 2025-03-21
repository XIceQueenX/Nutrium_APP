//
//  SortOption.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

enum SortOption: String, CaseIterable {
    case BEST_MATCH = "best_match"
    case RATING = "rating"
    case MOST_POPULAR = "most_popular"
    
    var description: String {
          switch self {
          case .BEST_MATCH:
              return "Best for You"
          case .RATING:
              return "Rating"
          case .MOST_POPULAR:
              return "Most Popular"
          }
      }
}
