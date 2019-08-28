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
    .textFonts(with: UIFont(name: "HelveticaNeue-Thin", size: 30)!)
  .build()
  

   let localSource = [BundleImageSource(imageString: "1"), BundleImageSource(imageString: "2"), BundleImageSource(imageString: "3"), BundleImageSource(imageString: "4")]
  
//  private let addTripTitle = UILabelFactory(text: "orderFood")
//    .textAlignment(with: .center)
//    .textFonts(with: UIFont.systemFont(ofSize: 19))
//    .textColor(with: UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1))
//    .build()
  
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
        newWindow(title: "OrderFood", message: "Welcome to New OrderFood! pick your current location foods nearby \(modelController.sharedInstance.CurrentLocation)", buttonTitle: "Ok", controller: self)
      }else{
        newWindow(title: "OrderFood", message: "Welcome to OrderFood", buttonTitle: "Ok", controller: self)
      }
      
      view.addSubview(currentLocation)
      
      
      self.tabBarCnt.delegate = self
      
      tableview.register(NotificationTableViewCell.self, forCellReuseIdentifier: "listCell")
      tableview.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(tableview)
      
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Ghuraiba", message: "Brittle cookies made from flour, butter, powdered sugar and cardamom. It's usually served with Arabic coffee.", image: "1"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "almsli", message: "Rice cooked with chicken, meat, fish or shrimp and the ingredients are cooked directly into the pot.", image: "2"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Figata", message: "White rice cooked with tomatoes and potatoes and eggplant in the bottom of the pan.", image: "3"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Jireesh", message: "A mash of cooked spelt with chicken or lamb, tomatoes, and some spices.", image: "4"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Mumawwash", message: "Rice cooked with Green lentils and can be topped with dry shrimp.", image: "5"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Muhammar", message: "Another rice dish made from local rice with dates or sugar, is one of the most distinctive rice dishes in Bahrain and is always served with fried fish, especially the net fish of Bahrain.", image: "6"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Ghuraiba", message: "Brittle cookies made from flour, butter, powdered sugar and cardamom. It's usually served with Arabic coffee.", image: "7"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "qirs altaabi ", message: "A dish made of Flour, eggs and ground cardamom to make a paste that is heated on a hot surface.", image: "8"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Qouzi", message: "A Bahraini dish consisting of a roasted lamb stuffed with rice, meat, eggs, and other ingredients.", image: "9"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Gaimat", message: "Fried yeast dumplings soaked in saffron syrup (sugar, lemon, and saffron).", image: "10"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Machboos,", message: " A dish made with mutton, chicken, or fish accompanied over fragrant rice that has been cooked in chicken/mutton well spiced broth", image: "11"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Mahyawa", message: "A tangy fish sauce", image: "12"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Harees", message: "Wheat cooked with meat then mashed, usually topped with cinnamon sugar.", image: "13"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Biryani", message: "A very common dish, which consists of heavily seasoned rice cooked with chicken or lamb. Originally from the Indian sub-continent", image: "14"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Khabeesa ", message: "Sweet dish made of flour and oil.", image: "15"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Zalabia", message: "Fried dough soaked in syrup (sugar, lemon, and saffron) it has a distinctive swirly shape.", image: "16"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Mumawwash", message: "Rice cooked with Green lentils and can be topped with dry shrimp.", image: "17"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "qirs", message: "A dish made of Flour, eggs and ground cardamom to make a paste that is heated on a hot surface.", image: "18"))
      NotificationAPI.shared.NotificationInstance.append(Notifications(id: "1", title: "Machboos", message: " A dish made with mutton, chicken, or fish accompanied over fragrant rice that has been cooked in chicken/mutton well spiced broth.", image: "19"))
      
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
      
//      addTripNavigationView.backgroundColor = UIColor.lightGray
//      view.addSubview(addTripNavigationView)
//      addTripNavigationView.addSubview(addTripTitle)
      
//      switch UIDevice().type {
//      case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
//        addTripNavigationView.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: view.frame.size.height/10.42 + 20.0, enableInsets: true)
//      default:
//        addTripNavigationView.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: view.frame.size.height/10.42, enableInsets: true)
//      }
//       addTripTitle.layoutAnchor(top: nil, left: nil, bottom: addTripNavigationView.bottomAnchor, right: nil, centerX: addTripNavigationView.centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 10.0, paddingRight: 0.0, width: 0.0, height: 21.0, enableInsets: true)
      
      slideshow.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0.0, height: view.frame.height/3, enableInsets: true)
      
      currentLocation.layoutAnchor(top: slideshow.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: view.centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: 30, enableInsets: true)
    
      
      tabBarHeight = tabBarCnt.tabBar.frame.size.height + 10
      switch UIDevice().type {
      case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
        tabBarHeight = tabBarCnt.tabBar.frame.size.height * 2
        tableview.layoutAnchor(top: currentLocation.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)

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
    let nextController = CartAccountViewController()
    let vc = NotificationAPI.shared.NotificationInstance[indexPath.row]
    
    
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
  
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let contentView = UIView(frame: CGRect(x: 5, y: 10, width: tableView.frame.size.width - 5, height: 40.0))
    contentView.clipsToBounds = true
    contentView.layer.masksToBounds = false
    contentView.layer.shadowColor = UIColor(red: 0.85, green: 0.89, blue: 0.91, alpha: 0.50).cgColor
    contentView.layer.shadowOpacity = 0.5
    contentView.layer.shadowRadius = 2
    contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
    contentView.layer.cornerRadius = 6
    contentView.layer.borderColor = UIColor(red: 0.86, green: 0.87, blue: 0.89, alpha: 0.30).cgColor
    contentView.layer.borderWidth = 1
    contentView.backgroundColor = UIColor.white
    contentView.alpha = 1
    
    
    let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: contentView.frame.height))
    label.font = UIFont(name: "Verdana", size: 20)
    label.textAlignment = .center
    label.text = "List of Hotels"
    label.textColor = UIColor.blue
    contentView.addSubview(label)
    
    return contentView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
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
    firstVc.tabBarItem = UITabBarItem(title: "OrderFood", image: UIImage(named: "FirstSel")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "View_All_Icon")?.withRenderingMode(.alwaysOriginal))
    
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
    self.view.bringSubviewToFront(tabBarCnt.view)
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let tabBarIndex = tabBarController.selectedIndex
    if tabBarIndex == 0 {
    }else if tabBarIndex == 1{
      let controller = CartAccountViewController()
      navigationController?.pushViewController(controller, animated: true)
    }else if tabBarIndex == 2{
      let controller = CartAccountViewController()
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}
