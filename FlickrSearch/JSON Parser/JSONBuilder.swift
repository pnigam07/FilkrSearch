//
//  JSONBuilder.swift
//  FlickrSearch
//
//  Created by pankaj on 7/17/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

class JSONBilder {
    
    func parseJSON(jsonData: Data, completionHandler : (_ parsedDataAsStruct: Photos) -> Void )  {
        do {
            let result = try JSONDecoder().decode(AllPhoto.self, from: jsonData)
            print(result)
            completionHandler(result.photos)
        } catch  {
            print(error)
        }
    }
}
