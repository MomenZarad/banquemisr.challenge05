//
//  UIViewExtension.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit

extension UIView {
    func setUpShadow(cornerRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowRadius: CGFloat = 4){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
    }
    
    @IBInspectable var cornerRadius : CGFloat{
        get{
            return CGFloat()
        }set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
}
