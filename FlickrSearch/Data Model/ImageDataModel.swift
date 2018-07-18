//
//  ImageDataModel.swift
//  FlickrSearch
//
//  Created by pankaj on 7/17/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

/*
 "id": "23451156376", "owner": "28017113@N08", "secret": "8983a8ebc7", "server": "578",
 "farm": 1,
 "title": "Merry Christmas!", "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0
 */
    
    struct Photo : Decodable {
        let id : String?
        let owner : String?
        let secret : String?
        let server : String?
        let title : String?
        let farm : Int?
        let ispublic : Int?
        let isfriend : Int?
        let isfamily : Int?
        
    }
    struct Photos : Decodable {
        let page : Int?
        let pages : UInt64?
        let perpage : UInt64?
        let total : String?
        let photo: [Photo]
    }

    struct AllPhoto : Decodable {
    let photos: Photos
}

