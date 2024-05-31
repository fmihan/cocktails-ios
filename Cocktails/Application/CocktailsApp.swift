//
//  CocktailsApp.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 23.05.2024..
//

import SwiftUI

@main
struct CocktailsApp: App {

    private var smallFont: UIFont {
        return UIFont(name: "Muli-Semibold", size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
    }

    var body: some Scene {
        WindowGroup {
            MainCoordinator()
        }
    }

    init() {
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let backButtonImage = UIImage(resource: .navigationBack)

        appearance.backgroundColor = .blue500
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: smallFont]
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)

        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
