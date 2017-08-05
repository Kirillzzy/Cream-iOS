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

  @IBOutlet var kolodaView: KolodaView! {
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

  var modelCollection: [TipEntity] {
    // FIXME: Delete below after loading from internet
    let tip = TipEntity()
    tip.text = "Hello everyone!"
    tip.title = "Greetings"
    return [tip, tip, tip, tip, tip]
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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

    return view
  }
}
