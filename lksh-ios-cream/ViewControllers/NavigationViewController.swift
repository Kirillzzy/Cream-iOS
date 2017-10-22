//
//  NavigationViewController.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.barTintColor = UIColor(.orange)
    navigationBar.isTranslucent = false
    navigationBar.tintColor = UIColor(.white)
    let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    navigationBar.titleTextAttributes = titleAttributes
  }

  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    viewControllers.last?.makeBackButtonEmpty()
    super.pushViewController(viewController, animated: animated)
  }
}
