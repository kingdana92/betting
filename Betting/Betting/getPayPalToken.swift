//
//  getPayPalToken.swift
//  Betting
//
//  Created by Myantel on 6/9/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class getPayPalToken: UIViewController {
    
    
    override func viewDidLoad() {
        testing()
    }
    
    
    func testing() {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://api.sandbox.paypal.com/v1/oauth2/token")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var err: NSError?
        request.setValue("Basic QWUyeHFsMGdOOEVIa1dzeS1XcHBUc0p5b255RnB2dllIUlNVVlRqU0didEJFaU1ONEJBZHdkLUZtUEFfeFY0dlpwWEU1OGQtSEJhTHVPS3A6RUhQS1FTQVlfQVpJSmM5M3VpZWVDeTVRVm1IQlk4eDFDT3FTc3pKdU1YRlJ6UEFkT0FxNWlKTWtJMG9CdEcybGVSaHpBUzljUzVNTElwMmk=", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let http_body = "grant_type=client_credentials".dataUsingEncoding(NSUTF8StringEncoding)

        request.HTTPBody = http_body

        //request.setValue("client_credentials", forUndefinedKey: "grant_type")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                if let parseJSON = json {
                    var success = parseJSON["success"] as? Int
                    println("Success: \(success)")
                    
                }
                else {
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        task.resume()
    }
    
}