//
//  AuthViewController.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit
import SVProgressHUD

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
  @IBOutlet fileprivate var loginButton: ActionButton! {
    didSet {
      loginButton.titleLabel?.font = UIFont.appFont(.avenirNextMedium(size: 18))
      loginButton.setTitle("Войти".localized, for: .normal)
      loginButton.layer.masksToBounds = true
      loginButton.layer.cornerRadius = 5
    }
  }
  @IBOutlet var placeholderLabel: UILabel! {
    didSet {
      placeholderLabel.isHidden = true
    }
  }
  @IBOutlet var placeholderViewBottomConstraint: NSLayoutConstraint!
  fileprivate var tapGesture: UITapGestureRecognizer!

  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardDelegate = self

    tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
    view.addGestureRecognizer(tapGesture)
  }

  @objc fileprivate func handleTapGesture(_ sender: UITapGestureRecognizer) {
    dismissKeyboard()
  }

  fileprivate func dismissKeyboard() {
    view.endEditing(true)
  }

  @IBAction fileprivate func loginButtonAction(_ sender: Any) {
    let login = loginTextField.text
    let password = passwordTextField.text

    if let login = login, let password = password,
      login != "", password != "" {
      SVProgressHUD.show()
      UIApplication.shared.beginIgnoringInteractionEvents()
      ApiManager.authorize(login: login, password: password, completion: { [weak self] (result) in
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
        if result {
          UserDefaultsHelper.notFirstSetup = true
          self?.performSegue(withIdentifier: "FromAuthViewController", sender: self)
        } else {
          if !UserDefaultsHelper.notFirstSetup {
            self?.placeholderLabel.isHidden = false
          }
        }
      })
    }
  }
}

// MARK: - KeyboardHandlerDelegate
extension AuthViewController: KeyboardHandlerDelegate {
  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {
    switch state {
    case .opened:
      placeholderViewBottomConstraint.constant += info.endFrame.height
    case .hidden:
      placeholderViewBottomConstraint.constant -= info.endFrame.height
    case .frameChanged: return
    }
  }
}
