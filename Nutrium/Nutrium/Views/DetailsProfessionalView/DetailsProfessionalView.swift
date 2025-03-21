//
//  DetailsProfessionalView.swift
//  Nutrium
//
//  Created by Gloria Martins on 19/03/2025.
//

import SwiftUI

struct DetailsProfessionalView: View {
    let professional: Professional
    
    @StateObject private var viewModel: DetailsProfessionalViewModel
    @State private var isExpanded = false
    
    init(professional: Professional) {
        self.professional = professional
        _viewModel = StateObject(wrappedValue: DetailsProfessionalViewModel(professional: professional))
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ZStack(alignment: .top){
                    Color.accentColor
                        .ignoresSafeArea()
                        .frame(height: viewModel.image == nil && !viewModel.isImageLoading ? 85 : 130)
                        .cornerRadius(20)
                    
                    HStack(alignment: .top) {
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        } else if viewModel.isImageLoading {
                            ZStack {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }

                        VStack(alignment: .leading) {
                            Text(viewModel.professional.name)
                                .font(.headline)
                                .fontWeight(.bold)

                            HStack(spacing: 5) {
                                StarRatingView(rating: viewModel.professional.rating, width: 100)
                                Text("\(viewModel.professional.rating.description) / 5\t(\(viewModel.professional.ratingCount))")
                                    .font(.caption)
                            }
                        }

                        Spacer()
                    }
                    .padding()
                }.padding()
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About me")
                        .font(.subheadline)
                        .fontWeight(.bold)

                    if let aboutMe = viewModel.professional.aboutMe {
                        VStack(alignment: .trailing, spacing: 8) {
                            Text(aboutMe)
                                .font(.body)
                                .lineLimit(isExpanded ? nil : 5)
                                .fixedSize(horizontal: false, vertical: true)

                            if !isExpanded && aboutMe.count > 100 {
                                Button(action: {
                                    isExpanded.toggle()
                                }) {
                                    Text("Show More")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            } else if isExpanded {
                                Button(action: {
                                    isExpanded.toggle()
                                }) {
                                    Text("Show Less")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding(.bottom)
                    } else if viewModel.isLoadingAboutMe {
                        Text("Loading description...")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    } else {
                        Text("No description available.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

                Spacer()
            }
    }
}
