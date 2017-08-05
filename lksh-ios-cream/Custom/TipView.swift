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
      mainView.layer.cornerRadius = 5
    }
  }
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
