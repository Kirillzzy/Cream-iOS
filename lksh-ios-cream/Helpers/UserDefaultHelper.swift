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

  private enum Keys {
    fileprivate static let notFirstSetup = "NotFirstSetup"
    fileprivate static let token = "Token"
  }

  static var notFirstSetup: Bool {
    get {
      return defaults.bool(forKey: Keys.notFirstSetup)
    }
    set {
      defaults.set(newValue, forKey: Keys.notFirstSetup)
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
