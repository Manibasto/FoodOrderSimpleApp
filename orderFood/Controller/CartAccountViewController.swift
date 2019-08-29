//
//  CartAccountViewController.swift
//  orderFood
//
//  Created by Anil Kumar on 27/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class CartAccountViewController: UIViewController {
    
    
    private let notificationBar = UIViewFactory()
        .build()
    
    private let addTripTitle = UILabelFactory(text: "Order Items")
        .textAlignment(with: .center)
        .textFonts(with: UIFont.systemFont(ofSize: 25))
        .textColor(with: UIColor.white)
        .build()
    
    let backButton = UIButtonFactory(title: "")
        .setBackgroundImage(image: "BackBtn")
        .addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        .setTintColor(color: UIColor.white)
        .build()
    
    let buyButton = UIButtonFactory(title: "Buy")
        .setTitileColour(with: .blue)
        .addTarget(self, action: #selector(buyClicked), for: .touchUpInside)
    .build()
  
  let amountLabel = UILabelFactory(text: "")
    .textColor(with: .blue)
  .build()
    
    let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buyButton)
        view.addSubview(tableview)
        view.backgroundColor = UIColor.white
        view.addSubview(amountLabel)
        notificationBar.backgroundColor = UIColor.lightGray
        view.addSubview(notificationBar)
        notificationBar.addSubview(addTripTitle)
        notificationBar.addSubview(backButton)
        setUpConstraintsToAttributes()
        tableview.allowsSelection = false
      tableview.allowsSelectionDuringEditing = false

        buyButton.layer.cornerRadius  = 5
        buyButton.layer.borderColor = UIColor.blue.cgColor
        buyButton.layer.borderWidth = 1.0
        
        tableview.register(secondCell.self, forCellReuseIdentifier: "cell1")
        
       tableViewInstances()
      
      amountLabel.layer.cornerRadius = 5
      amountLabel.layer.borderWidth = 1.0
      amountLabel.layer.borderColor = UIColor.blue.cgColor

      let tap = UITapGestureRecognizer(target: self, action: #selector(MoveNext))
      amountLabel.isUserInteractionEnabled = true
      amountLabel.addGestureRecognizer(tap)
      
        print(modelController.sharedInstance.passValue.last)
    }
  
  override func viewWillAppear(_ animated: Bool) {
     tableview.reloadData()
    getTotelAMount()
    
  }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradiantView(notificationBar, self)
    }
  
  @objc func MoveNext(){
    let vc = amountLabel.text
    if !(vc?.contains("Your"))!{
      let vc1 = foodViewController()
      navigationController?.pushViewController(vc1, animated: true)
    }
  }
    
    func setUpConstraintsToAttributes() {
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            
            notificationBar.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 102.0, enableInsets: true)
            
            if #available(iOS 11.0, *) {
              addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.safeAreaLayoutGuide.centerXAnchor, centerY: notificationBar.safeAreaLayoutGuide.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
            } else {
               addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.centerXAnchor, centerY: notificationBar.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
            }
            backButton.layoutAnchor(top: nil, left: notificationBar.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0.0, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
            if #available(iOS 11.0, *) {
              buyButton.layoutAnchor(top: amountLabel.bottomAnchor, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 100, height: 50, enableInsets: true)
            } else {
              buyButton.layoutAnchor(top: amountLabel.bottomAnchor, left: nil, bottom: view.bottomAnchor, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 100, height: 50, enableInsets: true)
          }
          amountLabel.layoutAnchor(top: tableview.bottomAnchor, left: nil, bottom: buyButton.topAnchor, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: view.frame.width/2+50, height: 50, enableInsets: true)
        default:
            notificationBar.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 82.0, enableInsets: true)
            
            addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.centerXAnchor, centerY: notificationBar.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
            
            backButton.layoutAnchor(top: nil, left: notificationBar.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0.0, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
            buyButton.layoutAnchor(top: amountLabel.bottomAnchor, left: nil, bottom: view.bottomAnchor, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 100, height: 50, enableInsets: true)
            amountLabel.layoutAnchor(top: tableview.bottomAnchor, left: nil, bottom: buyButton.topAnchor, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: view.frame.width/2+50, height: 50, enableInsets: true)
        }
        tableview.layoutAnchor(top: notificationBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 5, paddingBottom: 0.0, paddingRight: 5, width: 0.0, height: view.frame.height-70, enableInsets: true)
      
    }
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
}



extension CartAccountViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if NotificationAPI.shared.cartItems.isEmpty {
            tableView.setEmptyMessage("No Ordering Available")
            buyButton.isEnabled = false
            return  0
        }else{
          tableView.setEmptyMessage("")
            buyButton.isEnabled = true
            return NotificationAPI.shared.cartItems.count
        }
    }
    
    @objc func buyClicked(){
        showConfirmAlert(title: "Purchesed", message: "Product purchesed", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:  secondCell? = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? secondCell
        if cell == nil {
            cell = secondCell(style: .default, reuseIdentifier: "cell1")
        }
      cell?.desciptionLabel.tag  = indexPath.row
      cell?.desciptionLabel.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
    
        cell?.notification = NotificationAPI.shared.cartItems[indexPath.row]
        return cell!
    }
    private func tableViewInstances(){
        tableview.showsVerticalScrollIndicator = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
    }
  
  @objc func addClicked(sender:UIButton){
    NotificationAPI.shared.cartItems.remove(at: sender.tag)
    tableview.reloadData()
    getTotelAMount()
  }
  
  func getTotelAMount(){
    var amount = [Int]()
    if !NotificationAPI.shared.cartItems.isEmpty{
      for i in NotificationAPI.shared.cartItems {
        amount.append(Int(i.amount)!)
      }
      
      let amt = amount.compactMap(Double.init)
      let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.green]
      let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.blue]
      let attributedString1 = NSMutableAttributedString(string:"Your Order:   ", attributes:attrs1)
      let attributedString2 = NSMutableAttributedString(string:" \(amt.reduce(0, +)) BHD", attributes:attrs2)
      attributedString1.append(attributedString2)
      amountLabel.attributedText = attributedString1
      
    }else{
      amountLabel.text = "Continue Ordering!!"
    }
  }
}


