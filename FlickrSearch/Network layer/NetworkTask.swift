//
//  NetworkTask.swift
//  FlickrSearch
//
//  Created by pankaj on 7/15/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

protocol NetworkTaskDelegate {
    func successWithData(responseData:Data)
    func failWithError(error: Error)
}

class NetworkTask {
    
    var delegate : NetworkTaskDelegate?
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func GET(urlString: String, parameter:Dictionary<String, String>?,successBlock:@escaping  (Data) -> Void,failerBlock:@escaping (Error) -> Void)
    {
        dataTask?.cancel()
        if let urlComponents = URLComponents(string: urlString){
            guard let url = urlComponents.url else {return}
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error)
                    failerBlock(error)
                } else
                    if let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                      
                        successBlock(data)
                       
                }
                
            })
            dataTask?.resume()
        }
    }
    
    func GET(urlString: String, parameter:Dictionary<String, String>?)  {
        
        dataTask?.cancel()
        if let urlComponents = URLComponents(string: urlString){
            guard let url = urlComponents.url else {return}
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error)
                    self.delegate?.failWithError(error: error)
                } else
                    if let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.delegate?.successWithData(responseData: data)
                        }
                }
                
            })
            dataTask?.resume()
        }
    }
}
