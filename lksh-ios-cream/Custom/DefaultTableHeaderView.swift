//
//  DefaultTableHeaderView.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class DefaultTableHeaderView: UITableViewHeaderFooterView {

  static let font = UIFont.appFont(.avenirNextDemiBold(size: 16))

  static var titleInsets: UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
  }

  @IBOutlet var headerLabel: UILabel! {
    didSet {
      headerLabel.font = DefaultTableHeaderView.font
      headerLabel.textColor = UIColor(.gray)
      headerLabel.layoutMargins = DefaultTableHeaderView.titleInsets
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = UIColor(.lightGray).withAlphaComponent(1.0)
  }
}
