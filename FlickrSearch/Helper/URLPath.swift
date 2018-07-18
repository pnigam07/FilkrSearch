//
//  URL.swift
//  FlickrSearch
//
//  Created by pankaj on 7/15/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

class URLPath {
    
    let domainPath = "https://api.flickr.com/services/rest/"
    let domainPathForImage = "http://farm1.static.flickr.com/"
    
    var baseQueryParameter = ["method":"flickr.photos.search",
                              "api_key":"3e7cc266ae2b0e0d78e279ce8e361736",
                              "format":"json",
                              "nojsoncallback":"1",
                              "safe_search":"1"]
    var baseURLStringWithParam : String? {
        let queryString = domainPath+"?"+baseQueryParameter.queryString!
        return queryString
    }
    
   func searchURL(withText text:String) ->(String){
        let escapedString = text.stringByAddingPercentEncodingForRFC3986()
        let urlString = baseURLStringWithParam!+"&text=\(escapedString!)"
        return urlString
    }
    
    func imageURLUsingPhotoModel(photoModel: Photo?) -> String? {
        
        guard photoModel != nil else {
            return nil
        }
        var photoURL : String? {
            let url = "\(domainPathForImage)\( photoModel!.server!)/\(photoModel!.id!)_\(photoModel!.secret!).jpg"
            return url
        }
        return photoURL!
    }
}




