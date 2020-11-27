//
//  Extension.swift
//  MovieApp
//
//  Created by Emircan UZEL on 25.11.2020.
//

import Foundation
import UIKit

extension UIView{
    func bottomRoundedCorner(radius: Double) {
        self.layer.mask?.removeFromSuperlayer()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func topRoundedCorner(radius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    func corner(_ radius: CGFloat ) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    func border(_ color: UIColor,_ width: CGFloat ) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    func shadow(spread: CGFloat, color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: -15, height: 20)
        self.layer.shadowRadius = 10
//        self.layer.shadowPath = nil
        self.layer.masksToBounds = false
    }
}
