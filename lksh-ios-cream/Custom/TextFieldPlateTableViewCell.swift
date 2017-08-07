//
//  TextFieldTableViewCell.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class TextFieldPlateTableViewCell: UITableViewCell {
  @IBOutlet var textField: UITextField! {
    didSet {
      textField.textColor = UIColor(.darkGray)
      textField.font = UIFont.appFont(.avenirNextMedium(size: 17))
      textField.returnKeyType = .continue
    }
  }

  var valueChanged: ((String) -> Void)?
  var returnPressed: ((String) -> Void)?

  @IBAction func textFieldTextChanged(_ sender: UITextField) {
    valueChanged?(sender.text ?? "")
  }
}
