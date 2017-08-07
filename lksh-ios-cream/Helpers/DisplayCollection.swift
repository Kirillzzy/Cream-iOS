//
//  DisplayCollection.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

protocol DisplayCollection {
  var numberOfSections: Int { get }
  static var modelsForRegistration: [CellViewAnyModelType.Type] { get }

  func numberOfRows(in section: Int) -> Int
  func model(for indexPath: IndexPath) -> CellViewAnyModelType
}

protocol DisplayCollectionAction {
  func didSelect(indexPath: IndexPath)
}

extension DisplayCollection {
  var numberOfSections: Int {
    return 1
  }
}
