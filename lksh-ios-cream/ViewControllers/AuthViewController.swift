//
//  AuthViewController.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

  @IBOutlet fileprivate var titleLabel: UILabel! {
    didSet {
      titleLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 40))
      titleLabel.text = "Cream".localized
    }
  }
  @IBOutlet fileprivate var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.font = UIFont.appFont(.avenirNextMedium(size: 25))
      descriptionLabel.text = "Из проблем в сливки".localized
    }
  }
  @IBOutlet fileprivate var loginTextField: UITextField!
  @IBOutlet fileprivate var passwordTextField: UITextField!
  @IBOutlet fileprivate var loginButton: UIButton! {
    didSet {
      loginButton.titleLabel?.font = UIFont.appFont(.avenirNextMedium(size: 17))
      loginButton.setTitle("Войти".localized, for: .normal)
      loginButton.layer.masksToBounds = true
      loginButton.layer.cornerRadius = 5
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  @IBAction fileprivate func loginButtonAction(_ sender: Any) {
  }
}
