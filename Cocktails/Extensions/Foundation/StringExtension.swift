//
//  StringExtension.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
