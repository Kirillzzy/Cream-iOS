//
//  TipView.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class TipView: UIView {
  @IBOutlet fileprivate var mainView: UIView! {
    didSet {
      mainView.layer.masksToBounds = true
      mainView.layer.cornerRadius = 10
      mainView.layer.borderColor = UIColor(.darkGray).cgColor
      mainView.layer.borderWidth = 0.1
    }
  }
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      titleLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 20))
    }
  }
  @IBOutlet var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.font = UIFont.appFont(.avenirNextMedium(size: 17))
    }
  }
  @IBOutlet var nameLabel: UILabel! {
    didSet {
      nameLabel.font = UIFont.appFont(.avenirNextMedium(size: 13))
    }
  }
  @IBOutlet var dateLabel: UILabel! {
    didSet {
      dateLabel.font = UIFont.appFont(.avenirNextMedium(size: 13))
    }
  }

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
