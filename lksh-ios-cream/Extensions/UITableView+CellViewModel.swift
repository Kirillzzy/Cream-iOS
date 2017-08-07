//
//  UITableView+CellViewModel.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
  func dequeueReusableCell(for indexPath: IndexPath, with model: CellViewAnyModelType) -> UITableViewCell {

    let cellIdentifier = String(describing: type(of: model).cellClass())
    let cell = dequeueReusableCell(withIdentifier: cellIdentifier,
                                   for: indexPath)

    model.updateAppearance(of: cell, in: self, at: indexPath)
    model.setupDefault(on: cell)

    return cell
  }
}
