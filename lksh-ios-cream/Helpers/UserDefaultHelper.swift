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
    fileprivate static let token = "Token"
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

  static var token: String {
    get {
      return defaults.string(forKey: Keys.token) ?? ""
    }
    set {
      defaults.set(newValue, forKey: Keys.token)
    }
  }
}
