//
//  ImageDownloader.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import UIKit
import Foundation
import Combine

class ImageDownloader: UIImageView {
    var imageUrlString: String?
    var imageCache = NSCache<NSString, UIImage>()

    func loadImage(urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let cachedImage = self.imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data!) else { return }
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    self.imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }).resume()
        }
    }
}
