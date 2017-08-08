//
//  String+TimeConvert.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 08/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

extension String {
  func convertToReadableDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSSSSSZ"
    let date = dateFormatter.date(from: self)

    let goodDateFormatter = DateFormatter()
    goodDateFormatter.dateFormat = "E, d MMM"
    return goodDateFormatter.string(from: date ?? Date())
  }
}
