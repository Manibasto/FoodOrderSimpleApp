//
//  CustomLabel.swift
//  IDPal
//
//  Created by Anilkumar on 03/07/19.
//  Copyright © 2019 ID-Pal. All rights reserved.
//

import UIKit


class CustomLabel{
    let label  :UILabel
    init(text: String) {
        label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
  
  func setFont(_ fontName: String,size: CGFloat) -> Self {
    label.font = UIFont(name: fontName, size: size)
    return self
  }
    func changeFont(_ font :CGFloat) -> Self{
        label.font = label.font.withSize(font)
        return self
    }
    func changeTextColor(_ customTextColor:UIColor)-> Self{
        label.textColor = customTextColor
         return self
    }
    func changeTextAlignment(_ text:NSTextAlignment)-> Self{
        label.textAlignment = text
        return self
    }
    func hiddenLabel(_ bool:Bool)-> Self{
        label.isHidden = bool
        return self
    }
    func changeNumberOfLines(lines:Int)-> Self {
        label.numberOfLines = lines
        return self
    }
    func changeLineBreakMode(mode:NSLineBreakMode)->Self{
        label.lineBreakMode = mode
        return self
    }
    func addBorderColor() -> Self{
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 8
        return self
    }
    
    func buildUI() -> UILabel{
        return label
    }
    
    
}

