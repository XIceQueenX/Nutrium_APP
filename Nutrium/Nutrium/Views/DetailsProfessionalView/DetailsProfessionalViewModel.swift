//
//  DetailsProfessionalViewModel.swift
//  Nutrium
//
//  Created by Gloria Martins on 19/03/2025.
//

import Foundation
import UIKit

@MainActor
class DetailsProfessionalViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var professional: Professional
    @Published var isLoadingAboutMe: Bool = false
    @Published var isImageLoading: Bool = false
    
    init(professional: Professional) {
        self.professional = professional
        
        Task {
            await self.fetchAboutMe(for: professional.id)
            await self.downloadImage(url: professional.profilePictureUrl)
        }
    }
    
    func downloadImage(url: String) async {
        isImageLoading = true
               
        if let imageData = await Nutrium.downloadImage(from: url) {
            image = UIImage(data: imageData)
        }
        
        isImageLoading = false
    }
    
    func fetchAboutMe(for professionalId: Int) async {
        isLoadingAboutMe = true

        guard let fetchedProfessional = await API.shared.getProfessionalProfile(id: String(professionalId)) else {
            isLoadingAboutMe = false
            return
        }

        professional.aboutMe = fetchedProfessional.aboutMe
        isLoadingAboutMe = false
    }

}
