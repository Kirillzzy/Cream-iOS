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
    }
  }

  var modelCollection: DataModelCollection<TipEntity> {
    let dataCollection = DataModelCollection(type: TipEntity.self)
    return dataCollection
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    ApiManager.getPosts(completion: { tips, name in
      self.title = name
      realmWrite {
        for tip in tips {
          mainRealm.add(tip, update: true)
        }
      }

      self.kolodaView.delegate = self
      self.kolodaView.dataSource = self
    })
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    kolodaView.reloadData()
  }

  @IBAction fileprivate func dislikeButtonAction(_ sender: Any) {
    kolodaView.swipe(.left)
  }

  @IBAction fileprivate func likeButtonAction(_ sender: Any) {
    kolodaView.swipe(.right)
  }
  @IBAction fileprivate func exitButtonAction(_ sender: Any) {
    UserDefaultsHelper.firstSetup = true
    UserDefaultsHelper.token = ""
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
    view.descriptionLabel.setHTMLFromString(htmlText: item.text)
    view.nameLabel.text = item.creator
    view.rateLabel.text = "\(item.likes)"
    view.dateLabel.text = item.time.convertToReadableDate()

    return view
  }
}
