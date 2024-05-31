//
//  DetailsView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 30.05.2024..
//

import SwiftUI
import Kingfisher

struct DetailsView: View {

    @StateObject private var viewModel = ViewModel()

    private let id: String

    init(cocktailId: String) {
        self.id = cocktailId
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.detailsSections) { section in
                    switch section {
                    case .image(let imageUrl):
                        DetailsImageView(imageUrl: imageUrl)
                    case .filterCategories(let details):
                        DetailsFilterCategoriesView(details: details)
                        Divider()
                            .frame(minHeight: 1)
                            .overlay(Color.blue300)
                    case .ingredients(let ingredients):
                        DetailsIngredientsView(ingredients: ingredients)
                            .padding(.horizontal, 20)
                            .padding(.top, 8)

                        Divider()
                            .frame(minHeight: 1)
                            .overlay(Color.blue300)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                    case .directions(let directions):
                        DetailsDirectionsView(directions: directions)
                            .padding(.horizontal, 20)

                        Divider()
                            .frame(minHeight: 1)
                            .overlay(Color.blue300)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                    case .updatedAt(let time):
                        DetailsLastModifiedView(time: time)
                            .padding(.horizontal, 20)

                        Divider()
                            .frame(minHeight: 1)
                            .overlay(Color.blue300)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 20)

                    default:
                        EmptyView()
                    }
                }
            }
        }
        .background(.blue100)
        .navigationTitle(viewModel.cocktailName)
        .onAppear {
            viewModel.fetchDetails(for: id)
        }
    }
}

#Preview {
    DetailsView(cocktailId: "13501")
}
