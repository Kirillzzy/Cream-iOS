//
//  AskIssueViewModel.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class AskIssueViewModel: NSObject, DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [TextFieldPlateTableViewCellModel.self, TextFieldPlateTableViewCellModel.self]
  }

  enum `Type` {
    case title
    case description
  }

  var sections: [Type] = [
    .title,
    .description
  ]

  fileprivate(set) var titleText: String = ""
  fileprivate(set) var descriptionText: String = ""

  fileprivate(set) var textView: UITextView?

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let type = sections[indexPath.section]
    switch type {
    case .title:
      return TextFieldPlateTableViewCellModel(value: titleText,
                                              placeholder: "Заголовок".localized,
                                              textFieldDelegate: self,
                                              valueChanged: { [weak self] value in
                                                self?.titleText = value
      })
    case .description:
      return TextViewPlateTableViewCellModel(placeholder: "Описание".localized,
                                             textViewDelegate: self,
                                             delegate: self)
    }
  }

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    return 1
  }

}

extension AskIssueViewModel: UITextViewDelegate, TextViewPlateTableViewCellModelDelegate {
  func textViewDidChange(_ textView: UITextView) {
    descriptionText = textView.text
  }

  func model(model: TextViewPlateTableViewCellModel, didLoadTextView textView: UITextView) {
    self.textView = textView
  }
}

extension AskIssueViewModel: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nameIndex = sections.index(of: .title),
      let descriptionIndex = sections.index(of: .description),
      nameIndex < descriptionIndex {
      textView?.becomeFirstResponder()
      return false
    }
    return true
  }
}
