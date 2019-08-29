//
//  ListViewController.swift
//  orderFood
//
//  Created by Anil Kumar on 27/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import CoreLocation

class ListViewController: UIViewController {
  
//  private let addTripNavigationView = UIViewFactory()
//    .build()
  
  var slideshow = ImageSlideshow()
  var tabBarCnt               = UITabBarController()
  var tabBarHeight            = CGFloat()

  var AlertViewC : PopUp?
  var DimViewC: UIView?
  
  
  var currentLocation = UILabelFactory(text: "")
    .textColor(with: UIColor.gray)
    .textAlignment(with: .center)
    .textFonts(with: UIFont(name: "HelveticaNeue-Thin", size: 25)!)
  .build()
  

   let localSource = [BundleImageSource(imageString: "1"), BundleImageSource(imageString: "2"), BundleImageSource(imageString: "3"), BundleImageSource(imageString: "4")]
  
//  private let addTripTitle = UILabelFactory(text: "orderFood")
//    .textAlignment(with: .center)
//    .textFonts(with: UIFont.systemFont(ofSize: 19))
//    .textColor(with: UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1))
//    .build()
   var max = [String]()
  
  var amountArray = [String]()
  var amount = 150
  
  
  private var tableview = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableview.backgroundColor = UIColor.clear
      let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
      backgroundImage.image = UIImage(named: "bg")
      backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
      backgroundImage.addBlurEffect()
      self.view.insertSubview(backgroundImage, at: 0)
      
      createTabBarController()
      
      if !modelController.sharedInstance.CurrentLocation.isEmpty {
        newWindow(title: "OrderFood", message: "Welcome to \(modelController.sharedInstance.modelUserName)! pick your current location foods nearby \(modelController.sharedInstance.CurrentLocation)", buttonTitle: "Ok", controller: self)
      }else{
        newWindow(title: "OrderFood", message: "Welcome to  \(modelController.sharedInstance.modelUserName)!", buttonTitle: "Ok", controller: self)
      }
      
      view.addSubview(currentLocation)
      
      
      self.tabBarCnt.delegate = self
      
      tableview.register(NotificationTableViewCell.self, forCellReuseIdentifier: "listCell")
      tableview.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(tableview)
      
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Ghuraiba", message: "Brittle cookies made from flour, butter, powdered sugar and cardamom. It's usually served with Arabic coffee.", image: "1",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "almsli", message: "Rice cooked with chicken, meat, fish or shrimp and the ingredients are cooked directly into the pot.", image: "2",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Figata", message: "White rice cooked with tomatoes and potatoes and eggplant in the bottom of the pan.", image: "3",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Jireesh", message: "A mash of cooked spelt with chicken or lamb, tomatoes, and some spices.", image: "4",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Mumawwash", message: "Rice cooked with Green lentils and can be topped with dry shrimp.", image: "5",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Muhammar", message: "Another rice dish made from local rice with dates or sugar, is one of the most distinctive rice dishes in Bahrain and is always served with fried fish, especially the net fish of Bahrain.", image: "6",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Ghuraiba", message: "Brittle cookies made from flour, butter, powdered sugar and cardamom. It's usually served with Arabic coffee.", image: "7",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "qirs altaabi ", message: "A dish made of Flour, eggs and ground cardamom to make a paste that is heated on a hot surface.", image: "8",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Qouzi", message: "A Bahraini dish consisting of a roasted lamb stuffed with rice, meat, eggs, and other ingredients.", image: "9",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Gaimat", message: "Fried yeast dumplings soaked in saffron syrup (sugar, lemon, and saffron).", image: "10",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Machboos,", message: " A dish made with mutton, chicken, or fish accompanied over fragrant rice that has been cooked in chicken/mutton well spiced broth", image: "11",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Mahyawa", message: "A tangy fish sauce", image: "12",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Harees", message: "Wheat cooked with meat then mashed, usually topped with cinnamon sugar.", image: "13",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Biryani", message: "A very common dish, which consists of heavily seasoned rice cooked with chicken or lamb. Originally from the Indian sub-continent", image: "14",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Khabeesa ", message: "Sweet dish made of flour and oil.", image: "15",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Zalabia", message: "Fried dough soaked in syrup (sugar, lemon, and saffron) it has a distinctive swirly shape.", image: "16",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Mumawwash", message: "Rice cooked with Green lentils and can be topped with dry shrimp.", image: "17",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "qirs", message: "A dish made of Flour, eggs and ground cardamom to make a paste that is heated on a hot surface.", image: "18",amount: ""))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Machboos", message: " A dish made with mutton, chicken, or fish accompanied over fragrant rice that has been cooked in chicken/mutton well spiced broth.", image: "19",amount: ""))
      
      max = NotificationAPI.shared.NotificationInstance.map {($0.title ?? "")}
      
      for i in max {
        amountArray.append("\(amount)")
        let number = Int.random(in: 0 ... 10)
        amount = amount + number
      }
      
      for i in 0..<(NotificationAPI.shared.NotificationInstance.count){
        NotificationAPI.shared.NotificationInstance[i].amount = amountArray[i]
      }
      
      
      
      
      view.backgroundColor = UIColor.white
    
      currentLocation.text = "Current Location:"+modelController.sharedInstance.CurrentLocation
      
      slideshow.setImageInputs(localSource)
      
      let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
      slideshow.addGestureRecognizer(recognizer)

      
      
      slideshow.slideshowInterval = 2.0
      slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
      slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
      
      let pageControl = UIPageControl()
      pageControl.currentPageIndicatorTintColor = UIColor.red
      pageControl.pageIndicatorTintColor = UIColor.black
      slideshow.pageIndicator = pageControl
      
      // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
      slideshow.activityIndicator = DefaultActivityIndicator()
      slideshow.delegate = self
      
      view.addSubview(slideshow)
      tableViewInstances()
      
      
      slideshow.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0.0, height: view.frame.height/3, enableInsets: true)
      
      currentLocation.layoutAnchor(top: slideshow.bottomAnchor, left: nil , bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-20, height: 30, enableInsets: true)
    
      
      tabBarHeight = tabBarCnt.tabBar.frame.size.height + 10
      switch UIDevice().type {
          case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            tabBarHeight = tabBarCnt.tabBar.frame.size.height * 2

        if #available(iOS 11.0, *) {
          tableview.layoutAnchor(top: currentLocation.bottomAnchor, left: view.leftAnchor, bottom: tabBarCnt.tabBar.topAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        }else{
          tableview.layoutAnchor(top: currentLocation.bottomAnchor, left: view.leftAnchor, bottom: tabBarCnt.tabBar.topAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        }
      default:
        tableview.layoutAnchor(top: currentLocation.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: tabBarHeight, paddingRight: 5, width: 0, height: 0, enableInsets: true)
      }
      
  }
  
  func newWindow(title: String, message: String, buttonTitle: String, controller: UIViewController){
    let window = UIApplication.shared.keyWindow!
    DimViewC = UIView(frame: window.bounds)
    window.addSubview(DimViewC!)
    DimViewC?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    AlertViewC = PopUp(title: title, message: message, buttonTitle: buttonTitle, controller:controller, frame: CGRect(x: 20.0, y: DimViewC!.frame.size.height/4, width: DimViewC!.frame.size.width - 40, height: DimViewC!.frame.size.height/3))
    AlertViewC?.backgroundColor = UIColor.white
    AlertViewC?.delegate = controller as? popUDelegate
    DimViewC?.addSubview(AlertViewC!)
  }
  
  func removeAllViews(){
    AlertViewC?.removeFromSuperview()
    DimViewC?.removeFromSuperview()
  }
  
  private func tableViewInstances(){
    tableview.showsVerticalScrollIndicator = false
    tableview.dataSource = self
    tableview.delegate = self
    tableview.separatorStyle = .none
    tableview.tableFooterView = UIView()
    tableview.rowHeight = UITableView.automaticDimension
    tableview.estimatedRowHeight = 100
  }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension ListViewController : UITableViewDelegate, UITableViewDataSource,popUDelegate {
  
  func didTapButtonDismiss() {
    removeAllViews()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let nextController = foodViewController()
    let vc = NotificationAPI.shared.NotificationInstance[indexPath.row]
    modelController.sharedInstance.passValue.append(vc)
    navigationController?.pushViewController(nextController, animated: true)
  }
  
  override func viewDidLayoutSubviews() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return NotificationAPI.shared.NotificationInstance.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell:  NotificationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? NotificationTableViewCell
    if cell == nil {
      cell = NotificationTableViewCell(style: .default, reuseIdentifier: "listCell")
    }
    cell?.layer.backgroundColor = UIColor.clear.cgColor
    cell?.notification = NotificationAPI.shared.NotificationInstance[indexPath.row]
    return cell!
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
  
}

extension ListViewController: ImageSlideshowDelegate{
  func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
    print("current page:", page)
  }
  
  @objc func didTap() {
    let fullScreenController = slideshow.presentFullScreenController(from: self)
    fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
  }

}


extension ListViewController: UITabBarControllerDelegate{
  
  func createTabBarController() {
    tabBarCnt.tabBar.tintColor = UIColor.gray
    tabBarCnt.tabBar.barTintColor = UIColor.white
    self.tabBarCnt.tabBar.layer.shadowColor = UIColor.gray.cgColor
    self.tabBarCnt.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.tabBarCnt.tabBar.layer.shadowRadius = 5
    self.tabBarCnt.tabBar.layer.shadowOpacity = 0.5
    self.tabBarCnt.tabBar.layer.masksToBounds = false
    
    let firstVc = UIViewController()
    firstVc.title = "First"
    firstVc.tabBarItem = UITabBarItem(title: "Augumented Reality", image: UIImage(named: "FirstSel")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "View_All_Icon")?.withRenderingMode(.alwaysOriginal))
    
    let secondVc = UIViewController()
    secondVc.title = "Third"
    secondVc.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cartSe")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "cartUnse")?.withRenderingMode(.alwaysOriginal))
    
    let thirdVc = UIViewController()
    thirdVc.title = "Fourth"
    thirdVc.tabBarItem = UITabBarItem(title: "Food", image: UIImage(named: "Foosel")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "FooUnse")?.withRenderingMode(.alwaysOriginal))
    
    tabBarCnt.viewControllers = [firstVc, secondVc, thirdVc]
    
    
    let controllerArray = [firstVc, secondVc, thirdVc]
    tabBarCnt.viewControllers = controllerArray.map{ UINavigationController.init(rootViewController: $0)}
    
    self.view.addSubview(tabBarCnt.view)
    self.view.sendSubviewToBack(tableview)
    self.view.bringSubviewToFront(tabBarCnt.view)
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let tabBarIndex = tabBarController.selectedIndex
    if tabBarIndex == 0 {
      let arvc = ArKitViewController()
      navigationController?.pushViewController(arvc, animated: true)
    }else if tabBarIndex == 1{
      let controller = CartAccountViewController()
      navigationController?.pushViewController(controller, animated: true)
    }else if tabBarIndex == 2{
      let controller = foodViewController()
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}
