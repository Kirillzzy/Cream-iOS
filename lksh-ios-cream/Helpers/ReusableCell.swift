//
//  ReusableCell.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit.UINib

protocol ReusableCell {
  static var identifier: String { get }
  static var nib: UINib { get }
}
