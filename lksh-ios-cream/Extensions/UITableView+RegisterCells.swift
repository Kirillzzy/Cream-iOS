//
//  UITableView+RegisterCells.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

extension UITableView {
  func registerNibs(from displayCollection: DisplayCollection) {
    registerNibs(fromType: type(of: displayCollection))
  }

  private func registerNibs(fromType displayCollectionType: DisplayCollection.Type) {
    for cellModel in displayCollectionType.modelsForRegistration {
      if let tableCellClass = cellModel.cellClass() as? UITableViewCell.Type {
        registerNib(for: tableCellClass)
      }
    }
  }

  func registerNib(for cellClass: UITableViewCell.Type) {
    register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
  }
}
