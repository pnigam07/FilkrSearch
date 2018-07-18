//
//  CustomImageView.swift
//  FlickrSearch
//
//  Created by pankaj on 7/17/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        let url = NSURL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, respones, error) in
            if error != nil {
                print(error ?? "no value")
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                    self.contentMode = .scaleAspectFit
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }).resume()
    }
    
    func customActivityIndicatory(_ viewContrainer : UIView, startAnimating: Bool) {
        DispatchQueue.main.async {
            var activityIndicator  = UIActivityIndicatorView()
            
            if startAnimating{
                activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
                activityIndicator.center = self.center
                self.addSubview(activityIndicator)
                activityIndicator.startAnimating()
            }
            else{
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
