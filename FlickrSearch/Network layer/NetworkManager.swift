//
//  NetworkManager.swift
//  FlickrSearch
//
//  Created by pankaj on 7/15/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
    func successWithData(responseData:Data)
    func failWithError(error: Error)
}

class NetworkManager {

    func searchImageWithText(seatchText:String, andPageNumber: Int){
        let networkTask = NetworkTask()
        
        let urlPath = URLPath().searchURL(withText: seatchText, andPageNumber: andPageNumber)
        networkTask.GET(urlString: urlPath, parameter: nil)
        
    }
    
    func searchImageWithText(seatchText:String,
                             forPageNumber :Int,
                             successBlock: @escaping (_ successBlock: Data) -> Void, failerBlock:@escaping (Error) -> Void){
        let networkTask = NetworkTask()
        let urlPath = URLPath().searchURL(withText: seatchText, andPageNumber: forPageNumber)
        networkTask.GET(urlString: urlPath, parameter: nil, successBlock: { (jsonData) in
            successBlock(jsonData)
            
        }) { (error) in
            print(error.localizedDescription)
            failerBlock(error)
        }
        
    }
}
