//
//  Extension+ UIColor.swift
//  Go Record
//
//  Created by LinhMAC on 21/04/2024.
//

import Foundation
import UIKit
import Photos

extension UIView {
    func addLinearGradientBorderWithLocation(colors: [CGColor], locations: [NSNumber], width: CGFloat, cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.frame = bounds
        gradientLayer.mask = shapeLayer
        
        layer.addSublayer(gradientLayer)
    }
    
    func tabbarBorder(colors: [CGColor], locations: [NSNumber], width: CGFloat, cornerRadius: CGFloat, customShapePath: UIBezierPath) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = customShapePath.cgPath // Use custom shape path
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.frame = bounds
        gradientLayer.mask = shapeLayer
        
        layer.addSublayer(gradientLayer)
    }
    func addBottomBorder(){
        let bottomBorder = CALayer()
        
        bottomBorder.frame = CGRect(x: 0,
                                    y: self.frame.height,
                                    width: self.bounds.width,
                                    height: 0.5)
        bottomBorder.backgroundColor = UIColor(hex: "727DA0")?.cgColor
        layer.addSublayer(bottomBorder)
    }
}

