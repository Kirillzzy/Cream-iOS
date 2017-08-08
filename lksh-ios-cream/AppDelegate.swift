//
//  AppDelegate.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    RealmController.shared.setup()
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      if !UserDefaultsHelper.notFirstSetup {
        appDelegate.setRootViewController(with: "AuthViewController")
      } else {
        appDelegate.setRootViewController(with: "NavigationViewController")
      }
    }
    return true
  }

  func setRootViewController(with identifier: String, storyboard: String = "Main") {
    self.window?.rootViewController = UIStoryboard(name: storyboard,
                                                   bundle: nil).instantiateViewController(withIdentifier: identifier)
  }

  func setRootViewController(_ viewController: UIViewController) {
    self.window?.rootViewController = viewController
  }

}
