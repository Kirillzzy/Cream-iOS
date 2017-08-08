//
//  Realm+Writing.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 08/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
  public func realmWrite(_ block: (() -> Void)) {
    if isInWriteTransaction {
      block()
    } else {
      do {
        try write(block)
      } catch {
        NotificationCenter.default.post(name: .RealmWritingErrorNotifications,
                                        object: nil)
        assertionFailure("Realm write error: \(error)")
      }
    }
  }
}

func realmWrite(realm: Realm = mainRealm, _ block: (() -> Void)) {
  realm.realmWrite(block)
}
