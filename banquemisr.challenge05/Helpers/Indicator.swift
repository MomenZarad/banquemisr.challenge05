//
//  Indicator.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 19/03/2024.
//

import UIKit

public class Indicator {
    
    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    
    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = .medium
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .black
    }
    
    func showIndicator(){
        DispatchQueue.main.async( execute: {
            guard let scene = UIApplication.shared.connectedScenes.first,
                  let sceneDelegate = scene.delegate as? SceneDelegate,
                  let window = sceneDelegate.window else { return }
            window.addSubview(self.blurImg)
            window.addSubview(self.indicator)
        })
    }
    func hideIndicator(){
        DispatchQueue.main.async( execute:
                                    {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}
