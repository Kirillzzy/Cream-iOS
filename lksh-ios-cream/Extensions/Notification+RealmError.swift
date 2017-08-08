//
//  Notification+RealmError.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 08/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

extension Notification.Name {
  static let RealmLoadingErrorNotifications: Notification.Name =
    Notification.Name(rawValue: "RealmLoadingErrorNotifications")
  static let RealmWritingErrorNotifications: Notification.Name =
    Notification.Name(rawValue: "RealmWritingErrorNotifications")
}
