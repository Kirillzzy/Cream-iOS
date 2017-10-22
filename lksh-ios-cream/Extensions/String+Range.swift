//
//  String+Range.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

extension String {
  func substring(from index: Int) -> String {
    return String(self[characters.index(startIndex, offsetBy: index)...])
  }

  func substring(with range: Range<Int>) -> String {
    let startIndex = characters.index(self.startIndex, offsetBy: range.lowerBound)
    let endIndex = characters.index(self.startIndex, offsetBy: range.upperBound)
    return String(self[startIndex..<endIndex])
  }
}
