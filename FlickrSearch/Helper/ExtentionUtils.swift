//
//  Utils.swift
//  FlickrSearch
//
//  Created by pankaj on 7/17/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryString: String? {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        return output
    }
}

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?:"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
