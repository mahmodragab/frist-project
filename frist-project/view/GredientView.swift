//
//  GredientView.swift
//  frist-project
//
//  Created by abdallah ragab on 30/07/2022.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor(red: 75/255, green: 94/255, blue: 205/255, alpha: 1) {
    didSet {
        self.setNeedsLayout()
         }
    }
    @IBInspectable var bottomColor : UIColor =  UIColor(red: 42/255, green: 201/255, blue: 212/255, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor , bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
