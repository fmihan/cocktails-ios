//
//  FontsExtension.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI

extension Font {

    // MARK: - Font weight
    enum CCFontWeight {
        case bold
        case boldItalc
        case extraLigh
        case extraLightItalc
        case italic
        case light
        case lightItalic
        case semiboldItalic
        case semibold
        case regular
    }

    // MARK: - Typography

    static let A1Bold = ccFont(ofSize: 15, weight: .bold)
    static let A1 = ccFont(ofSize: 14, weight: .regular)

    // MARK: - Functions
    static func ccFont(ofSize: CGFloat) -> Font {
        return Font.custom("Muli", size: ofSize)
    }

    static func ccFont(ofSize: CGFloat, weight: CCFontWeight) -> Font {
        switch weight {
        case .bold:
            return Font.custom("Muli-Bold", size: ofSize)
        case .boldItalc:
            return Font.custom("Muli-BoldItalic", size: ofSize)
        case .extraLigh:
            return Font.custom("Muli-ExtraLight", size: ofSize)
        case .extraLightItalc:
            return Font.custom("Muli-ExtraLightItalic", size: ofSize)
        case .italic:
            return Font.custom("Muli-Italic", size: ofSize)
        case .light:
            return Font.custom("Muli-Light", size: ofSize)
        case .lightItalic:
            return Font.custom("Muli-LightItalic", size: ofSize)
        case .semiboldItalic:
            return Font.custom("Muli-Semi-BoldItalic", size: ofSize)
        case .semibold:
            return Font.custom("Muli-SemiBold", size: ofSize)
        case .regular:
            return Font.custom("Muli", size: ofSize)
        }
    }

}
