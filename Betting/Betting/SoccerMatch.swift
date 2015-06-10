//
//  SoccerLiveScore.swift
//  Betting
//
//  Created by Myantel on 5/28/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import UIKit

class SoccerMatch {
    //Get Matches
    var getMatchId = ""
    var getMatchCompId = ""
    var getMatchDate = ""
    var getMatchFormattedDate = ""
    var getMatchStatus = ""
    var getMatchTime = ""
    var getMatchCommentaryAvailable = ""
    var getMatchHomeTeamId = ""
    var getMatchHomeTeamName = ""
    var getMatchHomeTeamScore = ""
    var getMatchAwayTeamId = ""
    var getMatchAwayTeamName = ""
    var getMatchAwayTeamScore = ""
    var getMatchHalfTimeScore = ""
    var getMatchFullTimeScore = ""
    var getMatchExtraTimeScore = ""
    var getMatchPoolTotal = ""
    var getMatchLocalTeamTotal = ""
    var getMatchVisitorTeamTotal = ""
    var upcomingTime = ""
    var live = false
    //Event Array
    var eventArray : NSMutableArray = []

    
    //Setters
    func appendEvent(event : SoccerEvent) {
        eventArray.addObject(event)
    }
    
    func setMatchId(matchID : String) {
        getMatchId = matchID
    }
    
    func setCompId(compID : String) {
        getMatchCompId = compID
    }
    
    func setDate(setDate : String) {
        getMatchDate = setDate
    }
    
    func setFormattedDate(formattedDate : String) {
        getMatchFormattedDate = formattedDate
    }
    
    func setStatus(status : String) {
        getMatchStatus = status
    }
    
    func setTime(time : String) {
        getMatchTime = time
    }
    
    func setCommentaryAvailable(commentary : String) {
        getMatchCommentaryAvailable = commentary
    }
    
    func setHomeTeamId(homeTeamId : String) {
        getMatchHomeTeamId = homeTeamId
    }
    
    func setHomeTeamName(homeTeamName : String) {
        getMatchHomeTeamName = homeTeamName
    }
    
    func setHomeTeamScore(homeTeamScore : String) {
        getMatchHomeTeamScore = homeTeamScore
    }
    
    func setAwayTeamId(awayTeamId : String) {
        getMatchAwayTeamId = awayTeamId
    }
    
    func setAwayTeamName(away : String) {
        getMatchAwayTeamName = away
    }
    
    func setAwayTeamScore(away : String) {
        getMatchAwayTeamScore = away
    }
    
    func setHalfTimeScore(halftime : String) {
        getMatchHalfTimeScore = halftime
    }
    
    func setFullTimeSocre(fulltime : String) {
        getMatchFullTimeScore = fulltime
    }
    
    func setExtraTimeScore(extratime : String) {
        getMatchExtraTimeScore = extratime
    }
    
    func setPoolTotal(poolTotal : String) {
        getMatchPoolTotal = poolTotal
    }
    
    func setLocalTeamTotal(localTotal : String) {
        getMatchLocalTeamTotal = localTotal
    }
    
    func setVisitorTeamTotal(visitorTotal : String) {
        getMatchVisitorTeamTotal = visitorTotal
    }
    
    func setMatchtime(upcomingMatchTime : String) {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "GMT")
        let dateFString = dateFormatter.dateFromString(upcomingMatchTime)
        let upcomingDate = NSInteger(NSDate().timeIntervalSinceDate(dateFString!))
        var minutes = (upcomingDate / 60) % 60
        var correctMinute = minutes - minutes * 2
        var hours = (upcomingDate / 3600) - (upcomingDate / 3600 * 2)
        if correctMinute < 10 {
            upcomingTime = "\(hours):0\(correctMinute)"
        } else {
            upcomingTime = "\(hours):\(correctMinute)"
        }
        if hours == 0 && correctMinute == 0 {
            live = true
        } else {
            live = false
        }
    }
    
    //Getters
    func getEvent() -> NSMutableArray {
        return eventArray
    }
    
    func matchId() -> String {
        return getMatchId
    }
    
    func matchCompId() -> String {
        return getMatchCompId
    }
    
    func matchDate() -> String {
        return getMatchDate
    }
    
    func matchFormattedDate() -> String {
        return getMatchFormattedDate
    }
    
    func matchStatus() -> String {
        return getMatchStatus
    }
    
    func matchTime() -> String {
        return getMatchTime
    }
    
    func matchCommentaryAvailable() -> String {
        return getMatchCommentaryAvailable
    }
    
    func matchHomeTeamId() -> String {
        return getMatchHomeTeamId
    }
    
    func matchHomeTeamName() -> String  {
        return getMatchHomeTeamName
    }
    
    func matchHomeTeamScore() -> String {
        return getMatchHomeTeamScore
    }
    
    func matchAwayTeamId() -> String {
        return getMatchAwayTeamId
    }
    
    func matchAwayTeamName() -> String {
        return getMatchAwayTeamName
    }
    
    func matchAwayTeamScore() -> String {
        return getMatchAwayTeamScore
    }
    
    func matchHalfTimeScore() -> String {
        return getMatchHalfTimeScore
    }
    
    func matchFullTimeScore() -> String {
        return getMatchFullTimeScore
    }
    
    func matchExtraTimeScore() -> String {
        return getMatchExtraTimeScore
    }
    
    func matchPoolTotal() -> String {
        return getMatchPoolTotal
    }
    
    func matchLocalTeamTotal() -> String {
        return getMatchLocalTeamTotal
    }
    
    func matchVisitorTeamTotal() -> String {
        return getMatchVisitorTeamTotal
    }
    
    func getUpcomingTime() -> String {
        return upcomingTime
    }
    
}