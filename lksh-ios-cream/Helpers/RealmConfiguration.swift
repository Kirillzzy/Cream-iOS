//
//  RealmConfiguration.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 08/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

var mainRealm: Realm!

class RealmController {

  static var shared: RealmController = RealmController()

  func setup() {
    print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm Path")
    Realm.Configuration.defaultConfiguration =
      Realm.Configuration(schemaVersion: 0, migrationBlock: nil)

    do {
      mainRealm = try Realm()
    } catch let error as NSError {
      NotificationCenter.default.post(name: .RealmLoadingErrorNotifications,
                                      object: nil)
      assertionFailure("Realm loading error: \(error)")
    }
  }
}
