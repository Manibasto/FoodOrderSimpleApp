//
//  Model.swift
//  orderFood
//
//  Created by Anil Kumar on 27/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import Foundation
import UIKit

class modelController: NSObject {
  
  
  private static var privateSharedInstance: modelController?
  static var sharedInstance: modelController {
    if privateSharedInstance == nil {
      privateSharedInstance = modelController()
    }
    return privateSharedInstance!
  }
  class func destroy() {
    privateSharedInstance = nil
  }
  
  var CurrentLocation = String()
  var name = String()
  
  
}

protocol popUDelegate: class{
  func didTapButtonDismiss()
}

class PopUp : UIView {
  
  weak var delegate: popUDelegate? = nil
  
  var title: String?
  var message: String?
  var buttonTitle: String?
  var homeController: UIViewController?
  
  required init(title: String, message: String, buttonTitle: String, controller: UIViewController, frame: CGRect) {
    self.title = title
    self.message = message
    self.buttonTitle = buttonTitle
    self.homeController = controller
    super.init(frame: frame)
    setUpView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpView()
  }
  
  let imageview = UIImageFactory()
    .CornerRadious(radious: 5)
    .setImage(imageString: "PopUp_BGImage")
    .build()
  
  let homeLabel = UILabelFactory(text: "")
    .textAlignment(with: .center)
    .textColor(with: .white)
    .build()
  
  let currencyLabel = UILabelFactory(text: "")
    .textColor(with: UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0))
    .textAlignment(with: .center)
    .numberOf(lines: 0)
    .lineBreaking(mode: .byWordWrapping)
    .build()
  
  let button        = UIButtonFactory(title: "")
    .setTitileColour(with: UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0))
    .backgroundColour(with: .white)
    .textAlignmentButton(with: .center)
    .addTarget(self, action: #selector(didtabButton), for: .touchUpInside)
    .build()
  
  func setUpView(){
    layer.cornerRadius = 13.0
    backgroundColor    = .white
    
    additionalSubViews()
  }
  
  @objc func didtabButton(){
    print("tapped")
    delegate?.didTapButtonDismiss()
  }
  
  func additionalSubViews(){
    addSubview(imageview)
    imageview.addSubview(homeLabel)
    imageview.bringSubviewToFront(homeLabel)
    addSubview(currencyLabel)
    addSubview(button)
    homeLabel.text = title
    currencyLabel.text = message
    button.setTitle(buttonTitle, for: .normal)
    button.layer.cornerRadius = 10
    button.layer.borderColor = UIColor.blue.cgColor
    button.layer.borderWidth = 1.0
    setUpLayoutViews()
  }
  
  func setUpLayoutViews(){
    
    imageview.layoutAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 67, enableInsets: true)
    
    homeLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: imageview.centerXAnchor, centerY: imageview.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    
    currencyLabel.layoutAnchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: centerYAnchor, paddingTop: 0.0, paddingLeft: 5.0, paddingBottom: 0.0, paddingRight: 5.0, width: 0.0, height: 0.0, enableInsets: true)
    
    button.layoutAnchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, centerX: centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 10.0, paddingRight: 0.0, width: 100, height: 50, enableInsets: true)
  }
}



func gradiantView(_ Bar:UIView,_ Controller: UIViewController){
  let gradient: CAGradientLayer = CAGradientLayer()
  gradient.frame = CGRect(x: 0.0, y: 0.0, width: Controller.view.frame.size.width, height: Bar.frame.size.height)
  gradient.colors = [hexStringToUIColor(hex: "#55C6F8").cgColor, hexStringToUIColor(hex: "#3483D9").cgColor]
  Bar.layer.insertSublayer(gradient, at: 0)
}


func gradiantViewButton(_ button:UIButton){
  let gradient = CAGradientLayer()
  button.layer.cornerRadius = 25
  button.backgroundColor = .cyan
  gradient.frame = button.bounds
  gradient.colors = [hexStringToUIColor(hex: "#377ED6").cgColor,hexStringToUIColor(hex: "#00D2FF").cgColor]
  gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
  gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
  button.layer.insertSublayer(gradient, at: 0)
  let path = UIBezierPath(roundedRect:button.bounds, byRoundingCorners:[.bottomRight,.bottomLeft, .topLeft , .topRight], cornerRadii: CGSize(width: 21, height: 21))
  let maskLayer = CAShapeLayer()
  maskLayer.path = path.cgPath
  button.layer.mask = maskLayer
}


func hexStringToUIColor (hex:String) -> UIColor {
  var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
  
  if (cString.hasPrefix("#")) {
    cString.remove(at: cString.startIndex)
  }
  
  if ((cString.count) != 6) {
    return UIColor.gray
  }
  
  var rgbValue:UInt32 = 0
  Scanner(string: cString).scanHexInt32(&rgbValue)
  
  return UIColor(
    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
  )
}
