//
//  BottomButton.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class BottomButton: ActionButton {
  private struct Constants {
    static var height: CGFloat = 50
    static var backgroundColor: UIColor = UIColor(.orange)
    static var titleFont: UIFont = UIFont.appFont(.avenirNextDemiBold(size: 16))
    static var titleColor: UIColor = UIColor(.white)
  }

  static var constantHeight: CGFloat {
    return Constants.height
  }

  var bottomInsetsConstant: CGFloat = 0 {
    didSet {
      // Becuase it's bottom constaint, to go up it should be reversed
      bottomConstraint.constant = -bottomInsetsConstant
    }
  }

  private var bottomConstraint: NSLayoutConstraint!

  init(addingOnView view: UIView, title: String) {
    super.init(frame: .zero)

    view.addSubview(self)
    anchor(leading: view.leadingAnchor,
           trailing: view.trailingAnchor,
           heightConstant: Constants.height)

    bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)
    bottomConstraint.isActive = true

    setTitle(title, for: .normal)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    backgroundColor = Constants.backgroundColor
    titleLabel?.font = Constants.titleFont
    setTitleColor(Constants.titleColor, for: .normal)
  }
}
