//
//  UserDefaultHelper.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

final class UserDefaultsHelper {
  private static let defaults = UserDefaults.standard

  enum Keys {
    fileprivate static let firstSetup = "FirstSetup"
  }

  static var firstSetup: Bool {
    get {
      if !defaults.bool(forKey: Keys.firstSetup) {
        return true
      }
      return false
    }
    set {
      defaults.set(!newValue, forKey: Keys.firstSetup)
    }
  }
  
}
