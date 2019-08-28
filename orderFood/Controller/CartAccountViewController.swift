//
//  CartAccountViewController.swift
//  orderFood
//
//  Created by Anil Kumar on 27/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class CartAccountViewController: UIViewController {
  
  
  private let notificationBar = UIViewFactory()
    .build()
  
  private let addTripTitle = UILabelFactory(text: "Cart")
    .textAlignment(with: .center)
    .textFonts(with: UIFont.systemFont(ofSize: 19))
    .textColor(with: UIColor.white)
    .build()
  
  let backButton = UIButtonFactory(title: "")
    .setBackgroundImage(image: "BackBtn")
    .addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    .setTintColor(color: UIColor.white)
    .build()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    
    notificationBar.backgroundColor = UIColor.lightGray
    view.addSubview(notificationBar)
    notificationBar.addSubview(addTripTitle)
    notificationBar.addSubview(backButton)
    setUpConstraintsToAttributes()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    gradiantView(notificationBar, self)
  }
  
  func setUpConstraintsToAttributes() {
    switch UIDevice().type {
    case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
      
      notificationBar.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 102.0, enableInsets: true)
      
      addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.centerXAnchor, centerY: notificationBar.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
      backButton.layoutAnchor(top: nil, left: notificationBar.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0.0, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
    default:
      notificationBar.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 82.0, enableInsets: true)
      
      addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.centerXAnchor, centerY: notificationBar.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
      
      backButton.layoutAnchor(top: nil, left: notificationBar.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0.0, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
    }
    //    notificationTable.layoutAnchor(top: notificationBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 30.0, paddingBottom: 0.0, paddingRight: 30.0, width: 0.0, height: 0.0, enableInsets: true)
    
  }
  
  @objc func backButtonTapped(){
    navigationController?.popViewController(animated: true)
  }
}
