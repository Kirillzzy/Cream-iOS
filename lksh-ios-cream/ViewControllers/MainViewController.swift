//
//  MainViewController.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit
import Koloda

class MainViewController: UIViewController {

  @IBOutlet fileprivate var titleLabel: UILabel! {
    didSet {
      titleLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 24))
    }
  }
  @IBOutlet fileprivate var kolodaView: KolodaView! {
    didSet {
      modalTransitionStyle = .flipHorizontal
      kolodaView.alphaValueSemiTransparent = 1
      kolodaView.alphaValueTransparent = 1
      kolodaView.countOfVisibleCards = 2
      modalTransitionStyle = .flipHorizontal

      // FIXME: Move after loading from internet
      kolodaView.delegate = self
      kolodaView.dataSource = self
    }
  }
  @IBOutlet fileprivate var dislikeButton: UIButton!
  @IBOutlet fileprivate var likeButton: UIButton!
  @IBOutlet fileprivate var plusButton: UIButton!
  @IBOutlet fileprivate var exitButton: UIButton!

  var modelCollection: [TipEntity] {
    // FIXME: Delete below after loading from internet
    let tip = TipEntity()
    // swiftlint:disable:next line_length
    tip.text = "У нас в ГК нету коврика, из-за этого все страдают. На самом деле, много грязи и шняги. Если бы все подумали как решить эту проблему...."
    tip.title = "Коврик в ГК"
    tip.creator = "Kirill Averyanov"
    tip.likes = 15
    return [tip, tip, tip, tip, tip]
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction fileprivate func dislikeButtonAction(_ sender: Any) {
    kolodaView.swipe(.left)
  }

  @IBAction fileprivate func likeButtonAction(_ sender: Any) {
    kolodaView.swipe(.right)
  }

  @IBAction fileprivate func plusButtonAction(_ sender: Any) {
  }

  @IBAction fileprivate func exitButtonAction(_ sender: Any) {
  }
}

// MARK: - KolodaView
extension MainViewController: KolodaViewDelegate, KolodaViewDataSource {
  func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    return .default
  }

  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    kolodaView.resetCurrentCardIndex()
  }

  func kolodaSwipeThresholdRatioMargin(_ koloda: KolodaView) -> CGFloat? {
    return 0.5
  }

  func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
  }

  func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
    return modelCollection.count
  }

  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    // swiftlint:disable:next force_cast
    let view = Bundle.main.loadNibNamed("TipView", owner: self, options: nil)?.first as! TipView
    let item = modelCollection[index]
    view.titleLabel.text = item.title
    view.descriptionLabel.text = item.text
    view.nameLabel.text = item.creator
    view.rateLabel.text = "\(item.likes)"

    return view
  }
}
