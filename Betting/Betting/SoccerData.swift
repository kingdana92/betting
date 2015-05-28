//
//  SoccerData.swift
//  Betting
//
//  Created by Myantel on 5/26/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import UIKit

var footballApiKey = "849ab98c-654a-ba43-31b5c7258ed3"

class SoccerData {
    
    
    func getTeamName() {
        var team1Name : String
        var team2Name : String
        
        var url = "http://football-api.com/api/?Action=competitions&APIKey=" + footballApiKey
        let session = NSURLSession.sharedSession()
        let urlContent = NSURL(string: url)
        
        var task = session.dataTaskWithURL(urlContent!, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            } else {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                println(jsonResult["APIVersion"]!)
                
                
            }
            
        })
        task.resume()
        
    }
    
    func getMatchStatus() {
        var minute : Int
        var status : String
        var team1Score : Int
        var team2Score : Int
        var matchDate : String
        
        var url = "http://football-api.com/api/?Action=competitions&APIKey=" + footballApiKey
        let session = NSURLSession.sharedSession()
        let urlContent = NSURL(string: url)
        
        var task = session.dataTaskWithURL(urlContent!, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            } else {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                println(jsonResult["APIVersion"]!)
                
                
            }
            
        })
        task.resume()

    }
    
    
    func getBetPercentage() {
        var team1Percentage : Double
        var team2Percentage : Double
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.0.110/hohotest/api/users/confirm/format/json")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
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
    
    
    func uploadBet(userId : String, matchId : String, teamId : String, betAmount : String) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.0.110/hohotest/api/users/confirm/format/json")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["user_id":userId, "match_id":matchId, "team_id":teamId, "bet_amount":betAmount] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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

