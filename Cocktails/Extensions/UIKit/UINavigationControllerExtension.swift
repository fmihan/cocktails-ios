//
//  UINavigationControllerExtension.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import UIKit

extension UINavigationController {

  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    navigationBar.topItem?.backButtonDisplayMode = .minimal
  }

}
