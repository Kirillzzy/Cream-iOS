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
    return [TextFieldPlateTableViewCellModel.self, TextViewPlateTableViewCellModel.self]
  }

  weak var delegate: ActionsForViewController?

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
                                              placeholder: "Введите заголовок".localized,
                                              textFieldDelegate: self,
                                              valueChanged: { [weak self] value in
                                                self?.titleText = value
      })
    case .description:
      return TextViewPlateTableViewCellModel(placeholder: "Поясните ваше пожелание".localized,
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

  func height(for indexPath: IndexPath) -> CGFloat {
    switch sections[indexPath.section] {
    case .title:
      return 55
    case .description:
      return 175
    }
  }

  func headerHeight(for section: Int) -> CGFloat {
    switch sections[section] {
    case .title, .description:
      return 40
    }
  }

  func headerTitle(for section: Int) -> String {
    switch sections[section] {
    case .title:
      return "Заголовок".localized
    case .description:
      return "Описание".localized
    }
  }

  func bottomButtonAction() {
    if titleText != "", descriptionText != "" {
      ApiManager.sendProblem(title: titleText, description: descriptionText, completion: { [weak self] (tip) in
        realmWrite {
          mainRealm.add(tip, update: true)
        }
        guard let viewController = self?.delegate?.getViewController() else { return }
        viewController.navigationController?.popViewController(animated: true)
      })
    }
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
