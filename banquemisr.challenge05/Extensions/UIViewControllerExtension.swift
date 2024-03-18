//
//  UIViewControllerExtension.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 18/03/2024.
//

import UIKit

extension UIViewController {
    func showAlert(message : String)
    {
        // create the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
