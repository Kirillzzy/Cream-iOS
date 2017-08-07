//
//  TextFieldTableViewModel.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

struct TextFieldPlateTableViewCellModel {
  let value: String
  let placeholder: String
  weak var textFieldDelegate: UITextFieldDelegate?
  let valueChanged: ((String) -> Void)
}

extension TextFieldPlateTableViewCellModel: CellViewModelType {
  func setup(on cell: TextFieldPlateTableViewCell) {
    cell.textField.placeholder = placeholder
    cell.textField.delegate = textFieldDelegate
    cell.textField.text = value
    cell.valueChanged = valueChanged
  }
}
