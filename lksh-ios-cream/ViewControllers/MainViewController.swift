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
  @IBOutlet var endView: UIView! {
    didSet {
      endView.layer.masksToBounds = true
      endView.layer.cornerRadius = 10
      endView.isHidden = true
    }
  }
  @IBOutlet var endLabel: UILabel! {
    didSet {
      endLabel.font = UIFont.appFont(.avenirNextMedium(size: 25))
    }
  }
  fileprivate var modelCollection: DataModelCollection<TipEntity> = {
    let modelCollection = DataModelCollection(type: TipEntity.self)
    return modelCollection
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    ApiManager.getPosts(completion: { [weak self] (tips, name) in
      self?.title = name
      realmWrite {
        for tip in tips {
          mainRealm.add(tip, update: true)
        }
      }
      self?.kolodaView.delegate = self
      self?.kolodaView.dataSource = self
//      self?.kolodaView.reloadData()
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
    exitAction()
    performSegue(withIdentifier: "ExitToAuthViewController", sender: self)
  }

  private func exitAction() {
    UserDefaultsHelper.notFirstSetup = false
    UserDefaultsHelper.token = ""
    realmWrite {
      mainRealm.deleteAll()
    }
  }

}

// MARK: - KolodaView
extension MainViewController: KolodaViewDelegate, KolodaViewDataSource {
  func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    return .default
  }

  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
  }

  func kolodaSwipeThresholdRatioMargin(_ koloda: KolodaView) -> CGFloat? {
    return 0.5
  }

  func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
    switch direction {
    case .left, .bottomLeft, .topLeft:
      ApiManager.sendLike(problemId: modelCollection[index].id, isLiked: false)
    case .right, .bottomRight, .topRight:
      ApiManager.sendLike(problemId: modelCollection[index].id, isLiked: true)
    case .up, .down: break
    }
  }

  func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
    if modelCollection.count - 3 <= index {
      endView.isHidden = false
    }
  }

  func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
    return modelCollection.count
  }

  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    // swiftlint:disable:next force_cast
    let view = Bundle.main.loadNibNamed("TipView", owner: self, options: nil)?.first as! TipView
    let item = modelCollection[index]
    view.titleLabel.text = item.title
    view.descriptionTextView.setHTMLFromString(htmlText: item.text)
    view.nameLabel.text = item.creator
    view.likeLabel.text = "\(item.likes)"
    view.dislikeLabel.text = "\(item.dislikes)"
    view.dateLabel.text = item.time.convertToReadableDate()

    return view
  }
}
