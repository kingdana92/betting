//
//  SoccerData.swift
//  Betting
//
//  Created by Myantel on 5/26/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import UIKit

class SoccerData {
    
    func getSoccerData() {
        
        var url = "http://football-api.com/api/?Action=competitions&APIKey=849ab98c-654a-ba43-31b5c7258ed3"
        
        let session = NSURLSession.sharedSession()
        let urlContent = NSURL(string: url)
        
        var task = session.dataTaskWithURL(urlContent!, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            } else {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                println(jsonResult)
            }
            
        })
        task.resume()
    }
}

