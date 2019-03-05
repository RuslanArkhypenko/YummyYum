//
//  CardView.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 2/22/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowsOffSetWidth: CGFloat = 0
    @IBInspectable var shadowsOffSetHeight: CGFloat = 5
    @IBInspectable var shadowsColor: UIColor = .black
    @IBInspectable var shadowsOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowsColor.cgColor
        layer.shadowOffset = CGSize(width: shadowsOffSetWidth, height: shadowsOffSetHeight)
        layer.shadowOpacity = shadowsOpacity
    }
}
