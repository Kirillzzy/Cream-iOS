//
//  ActionsForViewController.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 08/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

protocol ActionsForViewController: class {
  func getViewController() -> UIViewController?
}

extension ActionsForViewController where Self: UIViewController {
  func getViewController() -> UIViewController? {
    return self
  }
}
