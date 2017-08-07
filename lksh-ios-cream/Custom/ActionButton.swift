//
//  ActionButton.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

  private var nessesaryBackgroundColor: UIColor?
  private var isSetup = false
  private var notChange = false

  override func awakeFromNib() {
    super.awakeFromNib()
    setUp()
  }

  private func setUp() {
    // Setup
  }

  override var backgroundColor: UIColor? {
    didSet {
      if oldValue == backgroundColor || notChange {
        notChange = false
        return
      }

      if !isSetup {
        nessesaryBackgroundColor = backgroundColor
        notChange = true
        backgroundColor = oldValue
      }
      updateAppearance()
    }
  }

  private func updateAppearance() {
    isSetup = true
    if (isSelected || isHighlighted) && isEnabled {
      backgroundColor = nessesaryBackgroundColor?.tapButtonChangeColor
    } else {
      backgroundColor = nessesaryBackgroundColor
    }
    alpha = isEnabled ? 1 : 0.8

    isSetup = false
  }

  override var isHighlighted: Bool {
    didSet {
      if oldValue != isHighlighted {
        notChange = true
        updateAppearance()
      }
    }
  }

  override var isEnabled: Bool {
    didSet {
      if oldValue != isEnabled {
        notChange = true
        updateAppearance()
      }
    }
  }

  override var isSelected: Bool {
    didSet {
      if oldValue != isSelected {
        notChange = true
        updateAppearance()
      }
    }
  }
}
