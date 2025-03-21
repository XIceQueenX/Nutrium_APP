//
//  ContentView.swift
//  Nutrium
//
//  Created by Gloria Martins on 18/03/2025.
//

import SwiftUI

struct ProfessionalsListView: View {
    @State private var showDetail = false
    @State private var selectedProfessional: Professional?
    @StateObject private var viewModel: ProfessionalListViewModel = ProfessionalListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(.nutrium)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Spacer()
                    
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.description)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.black)
                    .background(.lightGreen)
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ProfessionalsList(
                        professionals: viewModel.professionals,
                        onProfessionalTap: { professional in
                            selectedProfessional = professional
                            showDetail = true
                        },
                        onLoadMore: {
                            Task
                            {
                                await viewModel.fetchProfessionalsFromAPI()
                            }
                        }
                    )
                }
            }.padding()
                .navigationDestination(isPresented: $showDetail) {
                    if let selectedProfessional = selectedProfessional {
                        DetailsProfessionalView(professional: selectedProfessional)
                    }
                }
        }
    }
}

struct ProfessionalsList: View {
    let professionals: [Professional]
    let onProfessionalTap: (Professional) -> Void
    let onLoadMore: () -> Void
    
    var body: some View {
        List {
            ForEach(professionals, id: \.id) { professional in
                CardProfessional(professional: professional)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        onProfessionalTap(professional)
                    }
                    .onAppear {
                        if professional == professionals.last {
                            onLoadMore()
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
}
#Preview {
    ProfessionalsListView()
}

