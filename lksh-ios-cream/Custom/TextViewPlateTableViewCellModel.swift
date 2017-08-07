//
//  TextViewTableViewModel.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

protocol TextViewPlateTableViewCellModelDelegate: class {
  func model(model: TextViewPlateTableViewCellModel, didLoadTextView textView: UITextView)
}

struct TextViewPlateTableViewCellModel {
  let placeholder: String
  weak var textViewDelegate: UITextViewDelegate?
  weak var delegate: TextViewPlateTableViewCellModelDelegate?
}

extension TextViewPlateTableViewCellModel: CellViewModelType {
  func setup(on cell: TextViewPlateTableViewCell) {
    cell.textView.placeholder = placeholder
    cell.textView.delegate = textViewDelegate
    delegate?.model(model: self, didLoadTextView: cell.textView)
  }
}
