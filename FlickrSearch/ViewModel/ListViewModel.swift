//
//  ListViewModel.swift
//  FlickrSearch
//
//  Created by pankaj on 7/15/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

class ListViewModel : NSObject {
    
    var searchResult: [Photo]?
    let networkManager = NetworkManager()
    
    func searchImageWithText(searchText: String,completionBlock: @escaping ([Photo]) -> Void,failerBlock: @escaping (Error) -> Void) {
        
        networkManager.searchImageWithText(seatchText: searchText, successBlock: { (data) in
            JSONBilder().parseJSON(jsonData: data, completionHandler: { (photos) in
                self.searchResult = photos.photo
                completionBlock(photos.photo)
            })
        }) { (error) in
            print(error.localizedDescription)
            failerBlock(error)
        }
    }
}
