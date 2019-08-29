//
//  foodViewController.swift
//  orderFood
//
//  Created by Arun on 27/08/2019.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class foodViewController: UIViewController {
    
    private let notificationBar = UIViewFactory()
        .build()
    
//    var addedArray = [String:String]()

  var arrayValue:[String:(amount:String,value:String)] = [:]
  
    private let addTripTitle = UILabelFactory(text: "Food List")
        .textAlignment(with: .center)
        .textFonts(with: UIFont.systemFont(ofSize: 25))
        .textColor(with: UIColor.white)
        .build()
    
    let backButton = UIButtonFactory(title: "")
        .setBackgroundImage(image: "BackBtn")
        .addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        .setTintColor(color: UIColor.white)
        .build()
  
  let signOut = UIButtonFactory(title: "Sign Out")
    .addTarget(self, action: #selector(signOutBtn), for: .touchUpInside)
    .setTintColor(color: UIColor.white)
    .build()
    
    
    let locationManager = CLLocationManager()
    var mapview = MKMapView()
    
    let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<(NotificationAPI.shared.NotificationInstance.count) {
          arrayValue.updateValue((amount: NotificationAPI.shared.NotificationInstance[i].amount ?? "", value: "Add"), forKey: NotificationAPI.shared.NotificationInstance[i].title ?? "")
        }
      
      
      signOut.translatesAutoresizingMaskIntoConstraints = false
        tableview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableview)
        
        mapview.translatesAutoresizingMaskIntoConstraints = false
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        view.addSubview(mapview)
        
        mapview.delegate = self
        mapview.mapType = .standard
        mapview.isZoomEnabled = true
        mapview.isScrollEnabled = true
        
        if let coor = mapview.userLocation.location?.coordinate{
            mapview.setCenter(coor, animated: true)
        }
        
        tableViewInstances()
        view.backgroundColor = UIColor.white
        
        notificationBar.backgroundColor = UIColor.lightGray
        view.addSubview(notificationBar)
        notificationBar.addSubview(signOut)
        notificationBar.addSubview(addTripTitle)
        notificationBar.addSubview(backButton)
        setUpConstraintsToAttributes()
        tableview.allowsSelection = false
        tableview.allowsSelectionDuringEditing = false
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradiantView(notificationBar, self)
    }
  @objc func signOutBtn(){
    let alert = UIAlertController(title: "SignOut", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
      modelController.sharedInstance.name = ""
      modelController.sharedInstance.modelUserName = ""
      self.navigationController?.popToRootViewController(animated: true)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
    func setUpConstraintsToAttributes() {
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            
            notificationBar.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 102.0, enableInsets: true)
            
            backButton.layoutAnchor(top: nil, left: notificationBar.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0.0, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
            
            signOut.layoutAnchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 3, width: 90, height: 60, enableInsets: true)
            
            mapview.layoutAnchor(top: notificationBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height/3, enableInsets: true)
            
            if #available(iOS 11.0, *) {
              tableview.layoutAnchor(top: mapview.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0, paddingBottom: 0.0, paddingRight: 0, width: 0.0, height: 0.0, enableInsets: true)
              addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.safeAreaLayoutGuide.centerXAnchor, centerY: notificationBar.safeAreaLayoutGuide.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
            } else {
              tableview.layoutAnchor(top: mapview.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 0.0, height: 0.0, enableInsets: true)
              addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.centerXAnchor, centerY: notificationBar.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
          }
        default:
            notificationBar.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 82.0, enableInsets: true)
            
            addTripTitle.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: notificationBar.centerXAnchor, centerY: notificationBar.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20.0, enableInsets: true)
            
            backButton.layoutAnchor(top: nil, left: notificationBar.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0.0, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
            
            signOut.layoutAnchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: addTripTitle.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 3, width: 90, height: 60, enableInsets: true)
            
            mapview.layoutAnchor(top: notificationBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height/3, enableInsets: true)
            tableview.layoutAnchor(top: mapview.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0, paddingBottom: 0.0, paddingRight: 0, width: 0.0, height: 0.0, enableInsets: true)
        }
        tableview.register(firstCell.self, forCellReuseIdentifier: "firstCell")
    }

}

extension foodViewController: CLLocationManagerDelegate,MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapview.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapview.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = modelController.sharedInstance.CurrentLocation
        annotation.subtitle = "current location"
        mapview.addAnnotation(annotation)
    }
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
}

extension foodViewController: UITableViewDelegate,UITableViewDataSource{
    
    private func tableViewInstances(){
        tableview.showsVerticalScrollIndicator = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationAPI.shared.NotificationInstance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      var cell:  firstCell? = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as? firstCell
      if cell == nil {
        cell = firstCell(style: .default, reuseIdentifier: "firstCell")
      }
      cell?.desciptionLabel.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
      cell?.desciptionLabel.tag = indexPath.row
      let cv = arrayValue[NotificationAPI.shared.NotificationInstance[indexPath.row].title!]
      cell?.arrayValue = cv
      cell?.notification = NotificationAPI.shared.NotificationInstance[indexPath.row]
      
      return cell!
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc func addClicked(sender:UIButton){
      arrayValue.updateValue((amount: NotificationAPI.shared.NotificationInstance[sender.tag].amount ?? "", value: "Added"), forKey: NotificationAPI.shared.NotificationInstance[sender.tag].title ?? "")
        tableview.reloadRows(at: [ IndexPath(row: sender.tag,  section: 0)], with: .automatic)
         let ab = NotificationAPI.shared.NotificationInstance[sender.tag]
      let item = items(name: ab.title!, quantity: sender.tag, image: ab.image!, amount: ab.amount!)
        NotificationAPI.shared.cartItems.append(item)
    }
}


struct items{
    var name = String()
    var quantity = Int()
    var image = String()
    var amount = String()
    
  init(name : String, quantity: Int, image: String, amount: String) {
       self.name = name
       self.quantity = quantity
       self.image = image
      self.amount = amount
    }
}
