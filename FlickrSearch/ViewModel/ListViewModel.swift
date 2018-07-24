//
//  ListViewModel.swift
//  FlickrSearch
//
//  Created by pankaj on 7/15/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate {
    func listViewUpdated()
    
}

class ListViewModel : NSObject {
    
    var searchResult: [Photo]?
    let networkManager = NetworkManager()
    
    var didReachToLastCell : Bool = false
    var cuurentPageNumber = 1
    
    func searchImageWithText(searchText: String,completionBlock: @escaping ([Photo]) -> Void,failerBlock: @escaping (Error) -> Void) {
        
        networkManager.searchImageWithText(seatchText: searchText, forPageNumber:1, successBlock: { (data) in
            JSONBilder().parseJSON(jsonData: data, completionHandler: { (photos) in
                self.searchResult = photos.photo
                completionBlock(photos.photo)
            })
        }) { (error) in
            print(error.localizedDescription)
            failerBlock(error)
        }
    }
    
    func fetchNextPage(searchText: String,completionBlock: @escaping () -> Void,failerBlock: @escaping (Error) -> Void) {
        cuurentPageNumber += 1
        
        searchImageWithText(searchText: searchText, completionBlock: { (photos) in
            
            self.searchResult?.append(contentsOf: photos)
            completionBlock()
            
        }) { (error) in
            failerBlock(error)
        }
        
    }
}
