//
//  ViewController.swift
//  orderFood
//
//  Created by Anil Kumar on 27/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
  var loginManager               = LoginManager()
  var GroupedStatsStackView      = UIStackView()

  private let letsGoButton         = UIButtonFactory(title: "Login", style: .normal)
    .backgroundColour(with: UIColor.clear)
    .cornerRadious(with: 20.0)
    .textAlignmentButton(with: NSTextAlignment.center)
    .setTitileColour(with: UIColor.white)
    .addTarget(self, action: #selector(clickLogin), for: .touchUpInside)
    .build()
  
  private let faceBookBtn         = UIButtonFactory(title: "Facebook Login", style: .normal)
    .backgroundColour(with: UIColor.clear)
    .cornerRadious(with: 20.0)
    .textAlignmentButton(with: NSTextAlignment.center)
    .setTitileColour(with: UIColor.white)
    .addTarget(self, action: #selector(getFbLogin), for: .touchUpInside)
    .build()
  
  private let createAccount         = UIButtonFactory(title: "Create an Account", style: .normal)
    .backgroundColour(with: UIColor.clear)
    .cornerRadious(with: 20.0)
    .textAlignmentButton(with: NSTextAlignment.center)
    .setTitileColour(with: UIColor.white)
    .addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
    .build()
  
  let userName = UITextFieldFactory()
    .setKeyboardType(type: .emailAddress)
    .setFont(font: UIFont.systemFont(ofSize: 16))
    .textColor(color: UIColor.white)
    .build()
  
  let password = UITextFieldFactory()
    .setKeyboardType(type: .default)
    .setFont(font: UIFont.systemFont(ofSize: 16))
    .textColor(color: UIColor.white)
    .build()
  
  let logo = UIImageFactory()
    .setImage(imageString: "orderfood")
  .build()
  
  let orLabel = UILabelFactory(text: "OR")
    .fontSize(of: 20)
    .textColor(with: UIColor.white)
  .build()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    view.backgroundColor = UIColor.white
    
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    backgroundImage.image = UIImage(named: "bg")
    backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
    backgroundImage.addBlurEffect()
    self.view.insertSubview(backgroundImage, at: 0)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(tap)
    view.addSubview(logo)
    view.addSubview(faceBookBtn)
    loginManager.loginBehavior = .browser

    let arry = [userName,password]
    GroupedStatsStackView = UIStackViewFactory(buttons: arry)
      .build()
    
    view.addSubview(letsGoButton)
    
    userName.delegate = self
    password.delegate = self
    
    userName.text = "Basto@gmail.com"
    password.text = "1234456"
    
    userName.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
    userName.heightAnchor.constraint(equalToConstant: 63.0).isActive = true
    
    password.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
    password.heightAnchor.constraint(equalToConstant: 63.0).isActive = true
    
    
    userName.attributedPlaceholder = NSAttributedString(string: "Enter Username",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
    password.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
    
    userName.setLeftPaddingPoints(20)
    password.setLeftPaddingPoints(20)
    
    password.isSecureTextEntry = true
    userName.layer.cornerRadius = 10.0

    userName.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
    userName.layer.borderWidth = 0.5
    
    password.layer.cornerRadius = 10.0
    password.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
    password.layer.borderWidth = 0.5
    
    letsGoButton.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
    letsGoButton.layer.borderWidth = 0.5
    
    faceBookBtn.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
    faceBookBtn.layer.borderWidth = 0.5
    
    createAccount.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
    createAccount.layer.borderWidth = 0.5
    
    view.addSubview(GroupedStatsStackView)
    view.addSubview(orLabel)
    view.addSubview(createAccount)
    
    logo.layoutAnchor(top: nil, left: nil, bottom: GroupedStatsStackView.topAnchor, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 30, paddingRight: 0.0, width: 100, height: 100, enableInsets: true)
    switch UIDevice().type {
    case .iPad2,.iPad3,.iPad4,.iPadMini1,.iPadAir1,.iPadMini2,.iPadPro9_7,.iPadPro12_9,.iPadPro9_7_cell,.iPadPro10_5_cell,.iPadPro12_9_cell:
      GroupedStatsStackView.layoutAnchor(top: nil, left: nil,
                                         bottom: nil, right: nil,
                                         centerX: view.centerXAnchor, centerY: view.centerYAnchor,
                                         paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0,
                                         paddingRight: 0.0, width:view.frame.width-70, height:  view.frame.height/4-100, enableInsets: true)
    default:
      GroupedStatsStackView.layoutAnchor(top: nil, left: nil,
                                         bottom: nil, right: nil,
                                         centerX: view.centerXAnchor, centerY: view.centerYAnchor,
                                         paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0,
                                         paddingRight: 0.0, width:view.frame.width-70, height:  view.frame.height/4-50, enableInsets: true)
    }
    letsGoButton.layoutAnchor(top: GroupedStatsStackView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-70, height: 50, enableInsets: true)
    
    faceBookBtn.layoutAnchor(top: letsGoButton.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 20, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.width/2-20, height: 40, enableInsets: true)
    
    orLabel.layoutAnchor(top: faceBookBtn.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 30, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50, height: 40, enableInsets: true)
    
    createAccount.layoutAnchor(top: orLabel.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 30, paddingLeft: 0.0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: 40, enableInsets: true)
    
  }
  
  @objc func hideKeyboard(){
    view.endEditing(true)
  }
  
  override func viewDidLayoutSubviews() {
    logo.layer.cornerRadius = logo.frame.width/2
    logo.layer.masksToBounds = true
  }
  
  @objc func getFbLogin(){
    loginManager.logIn(permissions: [.publicProfile], viewController: self) { (loginResult) in
      switch loginResult {
      case .failed(let error):
        print(error as? String as Any)
      case .cancelled:
        return
      case .success( _, _, _):
        
        if(AccessToken.current != nil){
          GraphRequest(graphPath: "me", parameters: ["fields": "id,name , first_name, last_name , email,picture.width(480).height(480)"]).start(completionHandler: { (connection, result, error) in
            guard let Info = result as? [String: Any] else { return }
            
            guard let name = Info["name"] as? String else{ return }
            
            if let imageURL = ((Info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
              DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let controller = SignUpViewController()
                self.navigationController?.pushViewController(controller, animated: true)
              }
            }
            if(error == nil){
              print("result")
            }
          })
        }
      }
    }
  }
  
  @objc func createAccountTapped(){
    
    DispatchQueue.main.async {
      let controller = SignUpViewController()
      self.navigationController?.pushViewController(controller, animated: true)
    }
    
  }
  
  @objc func clickLogin(){
    
    guard let email = userName.text else { return }
    guard let password = password.text else { return }
    
    if (email.count != 0) && (password.count != 0) {
      if !isValidEmail(emailStr: email) {
        showConfirmAlert(title: "", message: "Please enter a valid email required fields!.", buttonTitle: "Cancel", buttonStyle: .default, confirmAction: nil)
      }else{
        letsGoButton.loadingIndicator(show: true)
        letsGoButton.setTitle("", for: .normal)
        delay(2) {
          self.letsGoButton.loadingIndicator(show: false)
          self.letsGoButton.setTitle("Login", for: .normal)
          self.showConfirmAlert(title: "Success", message: "Logged in Successfuly", buttonTitle: "Ok", buttonStyle: .default) { (action) in
            let controller = ListViewController()
            self.navigationController?.pushViewController(controller, animated: true)
          }
        }
      }
    }else{
      showConfirmAlert(title: "", message: "Please enter a valid value in all the required fields before proceeding.", buttonTitle: "Cancel", buttonStyle: .default, confirmAction: nil)
    }
  }
  
  func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
  }
}

extension LoginViewController: UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
      return true
  }
}
