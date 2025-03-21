//
//  Untitled.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

import SwiftUI

struct CardProfessional: View {
    let squareSize: CGFloat = 100
    let professional: Professional
    
    @State private var image: UIImage?
    
    
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0){
                HStack(alignment: .top, spacing: 10) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(width: squareSize, height: squareSize)
                    }
                    
                    VStack(alignment: .leading){
                        Text(professional.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack{
                            StarRatingView(rating: professional.rating, width: 100)
                            Text("\(professional.rating.description) / 5\t(\(professional.ratingCount))")
                                .font(.subheadline)
                        }
                        
                        HStack(spacing: 10){
                            Image(systemName: "globe")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(professional.languages, id: \.self) { profession in
                                        Text(profession)
                                            .font(.callout)
                                        
                                    }
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: 100)
                }.padding([.top, .horizontal], 20)
                
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(professional.expertise, id: \.self) { expertise in
                            LabelExpertise(text: expertise)
                        }
                    }
                }.padding(.horizontal)
            }.onAppear {
                Task {
                    image = await UIImage(data: downloadImage(from: professional.profilePictureUrl) ?? Data()) ?? nil
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(.accent)
        .cornerRadius(20)
        .padding(.vertical, 5)
    }
}


#Preview {
    CardProfessional(professional: Professional(
        expertise: ["iOS Development", "SwiftUI", "Backend"],
        id: 1,
        languages: ["Swift", "Python", "JavaScript"],
        name: "John Doe",
        profilePictureUrl: "https://example.com/profile.jpg",
        rating: 5,
        ratingCount: 42,
        aboutMe: "I am a passionate software developer specializing in mobile applications."
    ))
}
