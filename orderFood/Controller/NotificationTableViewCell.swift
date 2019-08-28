//
//  NotificationTableViewCell.swift
//  IDPal
//
//  Created by Anilkumar on 01/07/19.
//  Copyright © 2019 ID-Pal. All rights reserved.
//

import UIKit
/*Name: AIT-iOS
 *Date: 08-07-2019
 *Bug 1278 - Notifications often cannot be read
 *Desc: Created NotificationTableViewCell programmatically for nameLabel,desciptionLabel,logo and timeLabel.
 *Release: USPilot*/
class NotificationTableViewCell: UITableViewCell {
    
    var notification:Notifications? {
        didSet {
            guard let notificationList = notification else {return}
            if let title = notificationList.title{
                 nameLabel.text = title
            }
            if let message = notificationList.Message {
                desciptionLabel.text = " \(message) "
            }
            if let imageName = notificationList.image {
                //timeLabel.text = " \(date) "
              logo.image = UIImage(named: imageName)
              
            }
        }
    }
  
    //MARK: - cardView
    let boxView = UIViewFactory()
    .cornerRadious(value: 2.0).build()
    
    //MARK: - cell title Label
    let nameLabel = CustomLabel(text: "")
        .changeNumberOfLines(lines: 1)
        .setFont("Futura", size: 16)
        .buildUI()
    //MARK: - cell description Label
    let desciptionLabel = CustomLabel(text: "")
        .changeTextAlignment(.left)
        .changeLineBreakMode(mode: .byWordWrapping)
        .changeTextColor(UIColor.black.withAlphaComponent(0.8))
        .changeFont(12)
        .buildUI()
    //MARK: - IDPal Logo
    let logo : UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "idpal")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.contentView.backgroundColor = UIColor.clear
        boxView.backgroundColor = UIColor.clear
      desciptionLabel.textColor = .white
      nameLabel.textColor = .white
        setCardView(view: boxView)
        setCardView(view: logo)
        self.contentView.addSubview(boxView)
        boxView.layer.cornerRadius = 2.0;
//        boxView.backgroundColor = UIColor.white;
      
        let topConstraint = NSLayoutConstraint(item: boxView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 12)
        self.contentView.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: boxView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 12)
        self.contentView.addConstraint(leftConstraint)
        
        
        let rightConstraint = NSLayoutConstraint(item: boxView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -12)
        self.contentView.addConstraint(rightConstraint)
        
        let bottoConstraint = NSLayoutConstraint(item: boxView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -5)
        self.contentView.addConstraint(bottoConstraint)
      
        //Here label added to boxView
        boxView.addSubview(nameLabel)
        boxView.addSubview(desciptionLabel)
        boxView.addSubview(logo)
//        boxView.addSubview(timeLabel)

        ///NameLabel
        let topLabelConstraint = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self.boxView, attribute: .top, multiplier: 1, constant: 3)
        boxView.addConstraint(topLabelConstraint)
        
        let leftLabelConstraint = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: logo, attribute: .right, multiplier: 1, constant: 15)
        boxView.addConstraint(leftLabelConstraint)
        
        let rightLabelConstraint = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: boxView, attribute: .right, multiplier: 1, constant: -12)
        boxView.addConstraint(rightLabelConstraint)
        
        
        // Descritpion
        let topLabelConstraint1 = NSLayoutConstraint(item: desciptionLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 4)
        boxView.addConstraint(topLabelConstraint1)
        
        let leftLabelConstraint2 = NSLayoutConstraint(item: desciptionLabel, attribute: .left, relatedBy: .equal, toItem: logo, attribute: .right, multiplier: 1, constant: 15)
        boxView.addConstraint(leftLabelConstraint2)
        
        
        let rightLabelConstraint3 = NSLayoutConstraint(item: desciptionLabel, attribute: .right, relatedBy: .equal, toItem: boxView, attribute: .right, multiplier: 1, constant: -12)
        boxView.addConstraint(rightLabelConstraint3)
        
        // Golden line which do all the resizing of cell stuff
        let bottomSeparatorCosntraint = NSLayoutConstraint(item: desciptionLabel, attribute: .bottom, relatedBy: .equal, toItem: boxView, attribute: .bottom, multiplier: 1, constant: -12)
        boxView.addConstraint(bottomSeparatorCosntraint)
        
        
        //logo
        let imageConstraint2 = NSLayoutConstraint(item: logo, attribute: .left, relatedBy: .equal, toItem: boxView, attribute: .left, multiplier: 1, constant: 14)
        boxView.addConstraint(imageConstraint2)
        
        
        let imageConstraint3 = NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        boxView.addConstraint(imageConstraint3)
        
        let imageConstraint4 = NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        boxView.addConstraint(imageConstraint4)
        
        let imageConstraint5 = NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: boxView, attribute: .centerY, multiplier: 1, constant: 0)
        boxView.addConstraint(imageConstraint5)

 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.layer.shadowColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 0.50).cgColor
//        boxView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1)
        boxView.layer.borderWidth = 1.0
        boxView.layer.borderColor = UIColor(red: 255, green: 215, blue: 0, alpha: 0.1).cgColor
        boxView.alpha = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
  
  func setCardView( view: UIView) {
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 3.0
    view.layer.shadowOffset = CGSize(width: 0, height: 3)
    view.layer.shadowColor = UIColor.black.cgColor
  }
}


struct Notifications: Codable {
  let id: String?
  let title:String?
  let Message:String?
  let image:String?
  
  init(id:String,title:String,message:String,image:String) {
    self.id = id
    self.title = title
    self.Message = message
    self.image = image
  }
}


class NotificationAPI {
  
  private static var privateShared: NotificationAPI?
  
  static var shared: NotificationAPI {
    if privateShared == nil {
      privateShared = NotificationAPI()
    }
    return privateShared!
  }
  class func destroy() {
    privateShared = nil
  }
  
  var NotificationInstance : [Notifications] = []
  
}
