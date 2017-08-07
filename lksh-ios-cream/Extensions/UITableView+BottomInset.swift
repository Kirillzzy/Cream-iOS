//
//  UITableView+BottomInset.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit.UITableView
import ObjectiveC

private var associationKey = "tableView_bottom_inset"

struct TableViewConfiguration {
  var topInset: CGFloat?
  var bottomInset: CGFloat?
  var bottomIndicatorInset: CGFloat?
  var estimatedRowHeight: CGFloat?
  var rowHeight: CGFloat?
  var backgroundColor: UIColor

  /// Tricky necessity of struct initializer.
  /// Without it when initializing you have to pass all existing parameters for correct type matching
  init(
    topInset: CGFloat? = nil,
    bottomInset: CGFloat? = nil,
    bottomIndicatorInset: CGFloat? = nil,
    estimatedRowHeight: CGFloat? = nil,
    rowHeight: CGFloat? = nil,
    backgroundColor: UIColor = UIColor(.lightGray)
    ) {
    self.topInset = topInset
    self.bottomInset = bottomInset
    self.estimatedRowHeight = estimatedRowHeight
    self.bottomIndicatorInset = bottomIndicatorInset
    self.rowHeight = rowHeight
    self.backgroundColor = backgroundColor
  }

  static var `default` = defaultConfiguration
}

private var defaultConfiguration: TableViewConfiguration {
  return TableViewConfiguration(
    topInset: 8,
    bottomInset: 8,
    estimatedRowHeight: 100,
    rowHeight: UITableViewAutomaticDimension
  )
}

extension UITableView {

  private(set) var defaultBottomInset: CGFloat {
    get {
      return (objc_getAssociatedObject(self, &associationKey) as? CGFloat) ?? defaultConfiguration.bottomInset!
    }
    set {
      objc_setAssociatedObject(self, &associationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  enum ConfigurationType {
    case defaultConfiguration
    case custom(TableViewConfiguration)
  }

  func configure(with configuration: ConfigurationType) {
    switch configuration {
    case .defaultConfiguration:
      setup(configuration: defaultConfiguration)
    case let .custom(customConfig):
      setup(configuration: customConfig)
    }
  }

  private func setup(configuration: TableViewConfiguration) {
    if let topInset = configuration.topInset {
      self.contentInset.top = topInset
    }
    if let bottomInset = configuration.bottomInset {
      self.contentInset.bottom = bottomInset
      defaultBottomInset = bottomInset
    }
    if let bottomIndicatorInset = configuration.bottomIndicatorInset {
      self.scrollIndicatorInsets.bottom = bottomIndicatorInset
    }
    if let estimated = configuration.estimatedRowHeight {
      self.estimatedRowHeight = estimated
    }
    if let rowHeight = configuration.rowHeight {
      self.rowHeight = rowHeight
    }
    self.backgroundColor = configuration.backgroundColor
  }
  
}
