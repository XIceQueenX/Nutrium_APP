//
//  ProfessionalListViewModel.swift
//  Nutrium
//
//  Created by Gloria Martins on 19/03/2025.
//

import Foundation

@MainActor
class ProfessionalListViewModel: ObservableObject {
    @Published var professionals: [Professional] = []
    @Published var sortOption: SortOption = .BEST_MATCH {
        didSet {
            resetProfessionals()
        }
    }
    @Published var hasMoreData = true
    @Published var isLoading = false

    private var offset = 0
    private let limit = 4

    init() {
        loadProfessionals()
    }

    func loadProfessionals() {
        guard !isLoading, hasMoreData else { return }
        isLoading = true

        Task {
            await fetchProfessionalsFromAPI()
        }
    }

    func fetchProfessionalsFromAPI() async {
        guard let fetchedProfessionals = await API.shared.getProfessionals(sortOption: sortOption.rawValue, offset: offset) else {
            isLoading = false
            return
        }

        if fetchedProfessionals.isEmpty {
            hasMoreData = false
            isLoading = false
            return
        }

        professionals.append(contentsOf: fetchedProfessionals)
        offset += limit
        hasMoreData = fetchedProfessionals.count == limit
        isLoading = false
    }

    func resetProfessionals() {
        professionals.removeAll()
        offset = 0
        hasMoreData = true
        loadProfessionals()
    }
}
