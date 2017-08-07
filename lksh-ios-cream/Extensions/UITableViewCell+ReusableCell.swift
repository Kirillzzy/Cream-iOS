//
//  UITableViewCell+ReusableCell.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableCell {
  static var identifier: String {
    return String(describing: self)
  }

  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
}
