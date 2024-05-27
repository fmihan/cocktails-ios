//
//  RoundedButtonStyle.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    enum Style {
        case withTextPadding(ofSize: CGFloat)
        case withOuterPadding(ofSize: CGFloat)
    }

    var style: Style = .withTextPadding(ofSize: 20)

    private var willHaveFullWidth: Bool {
        switch style {
        case .withTextPadding:
            return false
        case .withOuterPadding:
            return true
        }
    }

    private var textPadding: CGFloat {
        switch style {
        case .withTextPadding(let ofSize):
            return ofSize
        case .withOuterPadding:
            return 0
        }
    }

    private var outerPadding: CGFloat {
        switch style {
        case .withTextPadding:
            return 0
        case .withOuterPadding(let ofSize):
            return ofSize
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, textPadding)
            .frame(maxWidth: willHaveFullWidth ? .infinity : nil, minHeight: 48)
            .font(.A1Bold)
            .background {
                if isEnabled {
                    configuration.isPressed ? Color.mutedBlue : Color.blue500
                } else {
                    Color.mutedBlue
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
            .foregroundColor(.white)
            .disabled(isEnabled)
            .padding(.horizontal, outerPadding)
    }

}
