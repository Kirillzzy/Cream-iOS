//
//  TextViewTableViewCell.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class TextViewPlateTableViewCell: UITableViewCell {
  @IBOutlet var textView: TextViewWithPlaceholder! {
    didSet {
      textView.textColor = UIColor(.darkGray)
      textView.font = UIFont.appFont(.avenirNextMedium(size: 17))
      textView.updatePlacholderViewStyle()
    }
  }
}
