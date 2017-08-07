//
//  AskIssueViewController.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class AskIssueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
//      tableView.registerHeaderNib(for: DefaultTableHeaderView.self)
    }
  }

  var viewModel: AskIssueViewModel!
  var bottomButton: BottomButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = AskIssueViewModel()
    tableView.registerNibs(from: viewModel)
    keyboardDelegate = self

    bottomButton = BottomButton(addingOnView: view, title: "Отправить".localized)
    bottomButton.addTarget(self, action: #selector(sendProblem), for: .touchUpInside)
  }

  func sendProblem() {
  }

  func dismissKeyboard() {
    view.endEditing(true)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = viewModel.model(for: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.height(for: indexPath)
  }

//  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return viewModel.headerHeight(for: section)
//  }

//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let header = tableView.dequeueReusableHeaderFooterView() as DefaultTableHeaderView
//    header.headerLabel.text = viewModel.headerTitle(for: section)
//    return header
//  }

}

// MARK: - KeyboardHandlerDelegate
extension AskIssueViewController: KeyboardHandlerDelegate {
  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {

    var scrollViewContentInsets = tableView.contentInset
    var indicatorInsets = tableView.scrollIndicatorInsets
    var buttonInsets: CGFloat = 0

    switch state {
    case .frameChanged, .opened:
      let scrollViewBottomInset = info.endFrame.height + tableView.defaultBottomInset + bottomButton.frame.height
      scrollViewContentInsets.bottom = scrollViewBottomInset
      indicatorInsets.bottom = info.endFrame.height + bottomButton.frame.height
      buttonInsets = info.endFrame.height
    case .hidden:
      scrollViewContentInsets.bottom = 0
      indicatorInsets.bottom = 0
      buttonInsets = 0
    }

    tableView.contentInset = scrollViewContentInsets
    tableView.scrollIndicatorInsets = indicatorInsets

    bottomButton.bottomInsetsConstant = buttonInsets
    info.animate ({ [weak self] in
      self?.view.layoutIfNeeded()
    })
  }
}
