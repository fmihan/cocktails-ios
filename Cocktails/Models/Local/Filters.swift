//
//  Filters.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 30.05.2024..
//

import SwiftUI
import Foundation

enum FilterCategory: Hashable {
    case glass
    case category
    case alcoholic

    var title: LocalizedStringKey {
        switch self {
        case .glass:
            return "filter.type.glass"
        case .category:
            return "filter.type.category"
        case .alcoholic:
            return "filter.type.alcoholic"
        }
    }

    var queryKey: String {
        switch self {
        case .glass:
            return "g"
        case .category:
            return "c"
        case .alcoholic:
            return "a"
        }
    }

    var image: ImageResource {
        switch self {
        case .glass:
            return .glass
        case .category:
            return .category
        case .alcoholic:
            return .alcoholic
        }
    }
}

struct FilterSection: Identifiable {
    var id = UUID().uuidString

    let type: FilterCategory
    let items: [CocktailFilter]
}
