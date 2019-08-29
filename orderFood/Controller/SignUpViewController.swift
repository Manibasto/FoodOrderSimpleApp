//
//  SignUpViewController.swift
//  orderFood
//
//  Created by Anil Kumar on 27/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

  
  let logo = UIImageFactory()
    .setImage(imageString: "orderfood")
    .build()
  
  let userName = UITextFieldFactory()
    .setKeyboardType(type: .default)
    .setFont(font: UIFont.systemFont(ofSize: 16))
    .textColor(color: UIColor.white)
    .build()
  
  let emailID = UITextFieldFactory()
    .setKeyboardType(type: .emailAddress)
    .setFont(font: UIFont.systemFont(ofSize: 16))
    .textColor(color: UIColor.white)
    .build()
  
  let password = UITextFieldFactory()
    .setKeyboardType(type: .default)
    .setFont(font: UIFont.systemFont(ofSize: 16))
    .textColor(color: UIColor.white)
    .build()
  
  let ConfirmPassword = UITextFieldFactory()
    .setKeyboardType(type: .default)
    .setFont(font: UIFont.systemFont(ofSize: 16))
    .textColor(color: UIColor.white)
    .build()
  
  private let letsGoButton         = UIButtonFactory(title: "SignUp", style: .normal)
    .backgroundColour(with: UIColor.clear)
    .cornerRadious(with: 20.0)
    .textAlignmentButton(with: NSTextAlignment.center)
    .setTitileColour(with: UIColor.white)
        .addTarget(self, action: #selector(clickLogin), for: .touchUpInside)
    .build()
  
  let profileImage = UILabelFactory(text: "Choose Image")
    .fontSize(of: 20)
    .textColor(with: UIColor.white)
    .build()

  
  private let signInBtn         = UIButtonFactory(title: "Already have an account? SignIn", style: .normal)
    .backgroundColour(with: UIColor.clear)
    .cornerRadious(with: 20.0)
    .textAlignmentButton(with: NSTextAlignment.left)
    .setTitileColour(with: UIColor.white)
    .addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    .build()
  
  var GroupedStatsStackView      = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.white
      
      let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
      backgroundImage.image = UIImage(named: "bg")
      backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
      backgroundImage.addBlurEffect()
      self.view.insertSubview(backgroundImage, at: 0)
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tap)
      
      userName.delegate = self
      emailID.delegate = self
      password.delegate = self
      ConfirmPassword.delegate = self
      
      
      userName.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
      userName.heightAnchor.constraint(equalToConstant: 63.0).isActive = true
      
      emailID.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
      emailID.heightAnchor.constraint(equalToConstant: 63.0).isActive = true
      
      password.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
      password.heightAnchor.constraint(equalToConstant: 63.0).isActive = true
      
      ConfirmPassword.widthAnchor.constraint(equalToConstant: 63.0).isActive = true
      ConfirmPassword.heightAnchor.constraint(equalToConstant: 63.0).isActive = true
      
      userName.attributedPlaceholder = NSAttributedString(string: "Username",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
      
      emailID.attributedPlaceholder = NSAttributedString(string: "Email id",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
      
      password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
      
      ConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
      
      userName.setLeftPaddingPoints(20)
      emailID.setLeftPaddingPoints(20)
      password.setLeftPaddingPoints(20)
      ConfirmPassword.setLeftPaddingPoints(20)
      
      password.isSecureTextEntry = true
      ConfirmPassword.isSecureTextEntry = true

      userName.layer.cornerRadius = 10.0
      emailID.layer.cornerRadius = 10.0
      password.layer.cornerRadius = 10.0
      ConfirmPassword.layer.cornerRadius = 10.0
      
      userName.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
      userName.layer.borderWidth = 0.5
      
      emailID.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
      emailID.layer.borderWidth = 0.5
      
      password.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
      password.layer.borderWidth = 0.5
      
      ConfirmPassword.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
      ConfirmPassword.layer.borderWidth = 0.5
      
      letsGoButton.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
      letsGoButton.layer.borderWidth = 0.5
      
      
      let arry = [userName,emailID,password,ConfirmPassword]
      GroupedStatsStackView = UIStackViewFactory1(buttons: arry)
        .build()
      
      view.addSubview(logo)
      
      view.addSubview(GroupedStatsStackView)
     
      view.addSubview(signInBtn)
      
      view.addSubview(letsGoButton)
      
      logo.layoutAnchor(top: nil, left: nil, bottom: GroupedStatsStackView.topAnchor, right: nil, centerX: GroupedStatsStackView.centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 60, paddingRight: 0, width: 100, height: 100, enableInsets: true)
      
      GroupedStatsStackView.layoutAnchor(top: nil, left: nil,
                                         bottom: nil, right: nil,
                                         centerX: view.centerXAnchor, centerY: view.centerYAnchor,
                                         paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0,
                                         paddingRight: 0.0, width:view.frame.width-70, height:  view.frame.height/3-10, enableInsets: true)
      letsGoButton.layoutAnchor(top: GroupedStatsStackView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 25, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.width/2-50, height: 40, enableInsets: true)
    
      signInBtn.layoutAnchor(top: letsGoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0.0, paddingRight: 20, width: 0.0
        , height: 40, enableInsets: true)
    }
    
  @objc func hideKeyboard(){
    view.endEditing(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
     self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillLayoutSubviews() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  @objc func backPressed(){
    DispatchQueue.main.async {
      self.navigationController?.popToRootViewController(animated: true)
    }
  }
  
  override func viewDidLayoutSubviews() {
    logo.layer.cornerRadius = logo.frame.width/2
    logo.layer.masksToBounds = true
  }
  
  @objc func clickLogin(){
    
    guard let user = userName.text else { return }
    guard let email = emailID.text else { return }
    guard let confirmPassword = ConfirmPassword.text else { return }
    guard let passwordStr = password.text else { return }
    
    if (user.count != 0) && (email.count != 0) && (confirmPassword.count != 0) && (passwordStr.count != 0) {
      if !isValidEmail(emailStr: email) {
        showConfirmAlert(title: "", message: "Please enter a valid email required fields!.", buttonTitle: "Cancel", buttonStyle: .default, confirmAction: nil)
      }else{
        letsGoButton.loadingIndicator(show: true)
        letsGoButton.setTitle("", for: .normal)
        delay(2) {
          self.letsGoButton.loadingIndicator(show: false)
          self.letsGoButton.setTitle("SignUp", for: .normal)
            modelController.sharedInstance.modelUserName = user
          self.showConfirmAlert(title: "Success", message: "Registered Successfuly", buttonTitle: "Ok", buttonStyle: .default) { (action) in
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
extension SignUpViewController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
