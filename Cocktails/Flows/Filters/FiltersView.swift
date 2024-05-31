//
//  FiltersView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
//

import SwiftUI
import FlowStacks

struct FiltersView: View {

    @EnvironmentObject var navigator: FlowNavigator<AppScreen>
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {

                ForEach(viewModel.sections) { section in
                    Section {
                        ForEach(section.items) { filter in
                            FiltersButtonView(
                                selected: viewModel.isSelected(filter, for: section.type),
                                title: filter.name
                            ) {
                                viewModel.selectFilter(filter, for: section.type)
                            }
                        }
                    } header: {
                        Text(section.type.title)
                            .kerning(-0.6)
                            .font(.A1Bold)
                            .foregroundStyle(.neutral900)
                            .padding(.top, 8)
                            .padding(.vertical, 4)
                    } footer: {
                        Rectangle()
                            .fill(.blue300)
                            .frame(height: 2)
                            .padding(.top, 16)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("filtersView.title")
        .safeAreaInset(edge: .bottom, content: {
            EmptyView()
                .frame(height: 100)
        })
        .background(.blue100)
        .overlay(alignment: .bottom) {
            Button("filtersView.button.search") {
                navigator.push(.filterResults(for: viewModel.selectedFilters))
            }
            .disabled(viewModel.selectedFilters.isEmpty)
            .buttonStyle(
                RoundedButtonStyle(
                    style: .withOuterPadding(ofSize: 24)
                )
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("filtersView.button.reset") {
                    viewModel.selectedFilters.removeAll()
                }
                .disabled(viewModel.selectedFilters.isEmpty)
                .font(.A1Bold)
                .kerning(-0.6)
                .tint(.white)
            }
        }
    }
}

#Preview {
    FiltersView()
}
