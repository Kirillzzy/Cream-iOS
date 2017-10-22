//
//  List+RemoveDublicates.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 08/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

extension List {
  func removeDublicates<T: Hashable>(rule: ((_ element: Element) -> T)) {
    var identifiers = Set<T>()
    var dublicatesIndexes = [Int]()

    for (index, value) in self.enumerated() {
      let identifier = rule(value)

      if identifiers.contains(identifier) {
        dublicatesIndexes.append(index)
      } else {
        identifiers.insert(identifier)
      }
    }

    while dublicatesIndexes.count > 0 {
      let last = dublicatesIndexes.removeLast()
      remove(at: last)
    }
  }
}
