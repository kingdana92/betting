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
    
    //API KEY
    var footballApiKey = "849ab98c-654a-ba43-31b5c7258ed3"
    
    //Classes
    var sMatch = SoccerMatch()
    var sLiveEvent = SoccerLiveEvent()
    
    //Method to call objected class Array
    //let nada: SoccerMatch = matchArray.objectAtIndex(1) as! SoccerMatch
    //println(nada.getMatchId)
    
    //Variables
    var matchArray : NSMutableArray = []
    var liveMatchArray : NSMutableArray = []

    
    //Functions
    func getFixtures() {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.0.101/football/api/match/get_fixtures/format/json")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            } else {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                if let match: AnyObject = jsonResult["match"] {
                    println(match)
                    for var x = 0; x < match.count; x++ {
                        if let fixture: AnyObject = match[x] {
                            
                            //Set Object
                            let objectBox: SoccerMatch = SoccerMatch()
                            objectBox.setMatchId(fixture["match_id"] as! String)
                            objectBox.setCompId(fixture["match_comp_id"] as! String)
                            objectBox.setCommentaryAvailable(fixture["match_commentary_available"] as! String)
                            objectBox.setDate(fixture["match_date"] as! String)
                            objectBox.setExtraTimeScore(fixture["match_et_score"] as! String)
                            objectBox.setFormattedDate(fixture["match_formatted_date"] as! String)
                            objectBox.setFullTimeSocre(fixture["match_ft_score"] as! String)
                            objectBox.setHalfTimeScore(fixture["match_ht_score"] as! String)
                            objectBox.setHomeTeamId(fixture["match_localteam_id"] as! String)
                            objectBox.setHomeTeamName(fixture["match_localteam_name"] as! String)
                            objectBox.setHomeTeamScore(fixture["match_localteam_score"] as! String)
                            objectBox.setStatus(fixture["match_status"] as! String)
                            objectBox.setTime(fixture["match_time"] as! String)
                            objectBox.setAwayTeamId(fixture["match_visitorteam_id"] as! String)
                            objectBox.setAwayTeamName(fixture["match_visitorteam_name"] as! String)
                            objectBox.setAwayTeamScore(fixture["match_visitorteam_score"] as! String)
                            
                            //Add To Array as Object
                            self.matchArray.addObject(objectBox)
                            
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    //Get Live Data
    func getLiveData() {
        
    }
    
    
    
    //Betting Process
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

