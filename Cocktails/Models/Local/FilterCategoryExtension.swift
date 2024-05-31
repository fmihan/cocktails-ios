//
//  FilterCategoryExtension.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

extension FilterCategory {
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
