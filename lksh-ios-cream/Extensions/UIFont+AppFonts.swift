//
//  UIFont+AppFonts.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit.UIFont

extension UIFont {
  enum FontType {
    case avenirNextDemiBold(size: CGFloat)
    case avenirNextMedium(size: CGFloat)
    case systemFont(size: CGFloat)
    case systemMediumFont(size: CGFloat)
  }

  static func appFont(_ fontType: FontType) -> UIFont {
    switch fontType {
    case let .avenirNextDemiBold(size):
      return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    case let .avenirNextMedium(size):
      return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    case let .systemFont(size):
      return UIFont.systemFont(ofSize: size)
    case let .systemMediumFont(size):
      return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
  }
}
