    //
    //  extension + UIView.swift
    //  Cooksantara App
    //
    //  Created by Sasha on 12.01.25.
    //

import UIKit


extension UIView {

    func addVerticalGradient(primaryColor: UIColor, secondaryColor: UIColor) {
        layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        gradient.locations = [0.0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }

    func addDropShadow(color: UIColor, opacity: Float, radius: CGFloat ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = radius
    }
}

