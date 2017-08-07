//
//  UITableView+Reuse.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    let identifier = T.identifier
    return dequeueReusableCell(withIdentifier: identifier,
                               for: indexPath) as! T // swiftlint:disable:this force_cast
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    let identifier = T.identifier
    return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T // swiftlint:disable:this force_cast
  }
}
