//
//  SoccerData.swift
//  Betting
//
//  Created by Myantel on 5/26/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import UIKit
import Parse

let notifKey = "gettingFixtures"

class SoccerData {
    
    
    
    //API KEY
    var footballApiKey = "849ab98c-654a-ba43-31b5c7258ed3"
    
    //Classes
    var sMatch = SoccerMatch()
    
    //Method to call objected class Array
    //let nada: SoccerMatch = matchArray.objectAtIndex(1) as! SoccerMatch
    //println(nada.getMatchId)
    
    //Classes
    var sTable = SoccerTableViewController()
    
    //Variables
    var matchArray : NSMutableArray = []
    
    //Functions
    func getFixtures() {
//        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.0.106/football/api/match/get_livescore/format/json")!)
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.0.106/football/api/match/get_fixtures/format/json")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            self.matchArray.removeAllObjects()
            if error != nil {
                println(error.localizedDescription)
            } else {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                if jsonResult["status"] as! String == "success" {
                    if let fixtures: AnyObject = jsonResult["fixtures"] {
                        for var y = 0; y < fixtures.count; y++ {
                            if let allMatch: AnyObject = fixtures[y] {
                                let objectBox: SoccerMatch = SoccerMatch()
                                //let poolTotal = String(stringInterpolationSegment: allMatch["pool_total"])
                                
                                objectBox.setPoolTotal(allMatch["pool_total"] as! String)
                                objectBox.setLocalTeamTotal(allMatch["localteam_total"] as! String)
                                objectBox.setVisitorTeamTotal(allMatch["visitorteam_total"] as! String)
                                
                                if let match: AnyObject = allMatch["match"] {
                                    //Set Object
                                    objectBox.setMatchId(match["match_id"] as! String)
                                    objectBox.setCompId(match["match_comp_id"] as! String)
                                    objectBox.setCommentaryAvailable(match["match_commentary_available"] as! String)
                                    objectBox.setDate(match["match_date"] as! String)
                                    objectBox.setExtraTimeScore(match["match_et_score"] as! String)
                                    objectBox.setFormattedDate(match["match_formatted_date"] as! String)
                                    objectBox.setFullTimeSocre(match["match_ft_score"] as! String)
                                    objectBox.setHalfTimeScore(match["match_ht_score"] as! String)
                                    objectBox.setHomeTeamId(match["match_localteam_id"] as! String)
                                    objectBox.setHomeTeamName(match["match_localteam_name"] as! String)
                                    objectBox.setHomeTeamScore(match["match_localteam_score"] as! String)
                                    objectBox.setStatus(match["match_status"] as! String)
                                    objectBox.setTime(match["match_time"] as! String)
                                    objectBox.setAwayTeamId(match["match_visitorteam_id"] as! String)
                                    objectBox.setAwayTeamName(match["match_visitorteam_name"] as! String)
                                    objectBox.setAwayTeamScore(match["match_visitorteam_score"] as! String)
                                    let formatDate = match["match_formatted_date"] as! String
                                    let formatTime = match["match_time"] as! String
                                    let setMatchTimeString = formatDate + " " + formatTime
                                    objectBox.setMatchtime(setMatchTimeString)
                                    
                                    self.matchArray.addObject(objectBox)

                                    if let event: AnyObject = match["match_events"] {
                                        for var loop = 0; loop < event.count; loop++ {
                                            if let allEvent: AnyObject = event[loop] {
                                                let eventBox : SoccerEvent = SoccerEvent()
                                                eventBox.setEventPlayer(allEvent["event_player"] as! String)
                                                eventBox.setEventId(allEvent["event_id"] as! String)
                                                eventBox.setEventMatchId(allEvent["event_match_id"] as! String)
                                                eventBox.setEventMinute(allEvent["event_minute"] as! String)
                                                eventBox.setEventTeam(allEvent["event_team"] as! String)
                                                eventBox.setEventType(allEvent["event_type"] as! String)
                                                eventBox.setEventResult(allEvent["event_result"] as! String)
                                                eventBox.setEventPlayerId(allEvent["event_player_id"] as! String)
                                                objectBox.eventArray.addObject(eventBox)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                } else {
                    println("no match")
                }
            }
            if rControl != nil {
                rControl.endRefreshing()
            }
            NSNotificationCenter.defaultCenter().postNotificationName(notifKey, object: self)
        })
        task.resume()

    }
    
    
    //Betting Process
    func uploadBet(userId : String, matchId : String, teamId : String, teamId2 : String, betAmount : String, payPalId : String) {
        var bpvc = BetPageViewController()
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.0.106/football/api/match/user_betting/format/json")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["user_id":userId,"match_id":matchId,"amount":betAmount,"match_localteam":teamId,"match_vistorteam":teamId2,"approved_id":payPalId] as Dictionary<String, String>
        
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
                    var success = parseJSON["success"] as? String
                    println("Success: \(success)")
                }
                else {
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
            //Call anything here (to end indicator or some sorts)
            NSNotificationCenter.defaultCenter().postNotificationName("paypalDone", object: self)

        })
        task.resume()
    }
}

