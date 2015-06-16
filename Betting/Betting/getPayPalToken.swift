//
//  getPayPalToken.swift
//  Betting
//
//  Created by Myantel on 6/9/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class getPayPalToken: UIViewController {
    
    
    var payPalAuthKey = "Basic QWUyeHFsMGdOOEVIa1dzeS1XcHBUc0p5b255RnB2dllIUlNVVlRqU0didEJFaU1ONEJBZHdkLUZtUEFfeFY0dlpwWEU1OGQtSEJhTHVPS3A6RUhQS1FTQVlfQVpJSmM5M3VpZWVDeTVRVm1IQlk4eDFDT3FTc3pKdU1YRlJ6UEFkT0FxNWlKTWtJMG9CdEcybGVSaHpBUzljUzVNTElwMmk="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.blackColor()
        addSavingPhotoView()
        
        //Custom button to test this app
        var button = UIButton(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(button)
    }
    
    func addSavingPhotoView() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.whiteColor()
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        var activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        var textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.grayColor()
        textLabel.text = "Saving Photo"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }
    
    func buttonAction(sender:UIButton!) {
        //When button is pressed it removes the boxView from screen
        boxView.removeFromSuperview()
    }
    
    func testing() {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://api.sandbox.paypal.com/v1/oauth2/token")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var err: NSError?
        request.setValue(payPalAuthKey, forHTTPHeaderField: "Authorization")
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