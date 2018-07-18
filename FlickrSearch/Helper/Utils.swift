//
//  Utils.swift
//  FlickrSearch
//
//  Created by pankaj on 7/18/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    class func displayAlertView(titleText: String, message: String, viewController: UIViewController) {
        
        let errorAlert = UIAlertController(title: titleText, message: message, preferredStyle: UIAlertControllerStyle.alert)
        viewController.present(errorAlert, animated: true, completion: nil)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
            switch action.style {
            case .default:
                break
            default:
                break
            }
        }))
    }
    
    class func displayAlertViewWithCustomAction(titleText: String, message: String, viewController: UIViewController,action:UIAlertAction) {
        let errorAlert = UIAlertController(title: titleText, message: message, preferredStyle: UIAlertControllerStyle.alert)
        viewController.present(errorAlert, animated: true, completion: nil)
        errorAlert.addAction(action)
    }
}
