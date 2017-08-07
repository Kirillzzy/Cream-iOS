//
//  UIColor+ColorsPalette.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
  enum ColorType {
    case gray
    case darkGray
    case strongGray
    case red
    case white
    case black
    case lightGray
    case thinLightGray
    case pink
    case blue
    case orange
  }

  convenience init(_ colorType: ColorType) {
    switch colorType {
    case .gray:
      self.init(hexString: "8C8C8C")
    case .strongGray:
      self.init(hexString: "555555")
    case .darkGray:
      self.init(hexString: "6C6C6C")
    case .red:
      self.init(hexString: "FF2A68") //DB1D5F
    case .white:
      self.init(hexString: "FDFEFE")
    case .black:
      self.init(hexString: "000000")
    case .lightGray:
      self.init(hexString: "E3E5E5")
    case .thinLightGray:
      self.init(hexString: "F7F7F7")
    case .pink:
      self.init(hexString: "C550DC")
    case .blue:
      self.init(hexString: "1AD6FD") //5AC8FB
    case .orange:
      self .init(hexString: "FAA41A")
    }
  }
}
