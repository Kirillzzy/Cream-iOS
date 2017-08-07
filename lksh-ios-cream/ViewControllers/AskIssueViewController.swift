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

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = AskIssueViewModel()
    tableView.registerNibs(from: viewModel)

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

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return viewModel.headerHeight(for: section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView() as DefaultTableHeaderView
    header.headerLabel.text = viewModel.headerTitle(for: section)
    return header
  }


}
