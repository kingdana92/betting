//
//  SoccerLiveEvent.swift
//  Betting
//
//  Created by Myantel on 5/28/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import UIKit

class SoccerLiveEvent {
    
    var getEventId = ""
    var getEventMatchId = ""
    var getEventType = ""
    var getEventMinute = ""
    var getEventTeam = ""
    var getEventPlayer = ""
    var getEventPlayerId = ""
    var getEventResult = ""
    
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
    
    //Setters
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
    
    
    //Getters
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
    
    //EVENTS
    //Setters
    func setEventId(event : String) {
        getEventId = event
    }
    
    func setEventMatchId(eventId : String) {
        getEventMatchId = eventId
    }
    
    func setEventType(eventType : String) {
        getEventType = eventType
    }
    
    func setEventMinute(eventMinute : String) {
        getEventMinute = eventMinute
    }
    
    func setEventTeam(eventTeam : String) {
        getEventTeam = eventTeam
    }
    
    func setEventPlayer(eventPlayer : String) {
        getEventPlayer = eventPlayer
    }
    
    func setEventPlayerId(eventPlayerId : String) {
        getEventPlayerId = eventPlayerId
    }
    
    func setEventResult(eventResult : String) {
        getEventResult = eventResult
    }
    
    //Getters
    func eventId() -> String {
        return getEventId
    }
    
    func eventMatchId() -> String {
        return getEventMatchId
    }
    
    func eventType() -> String {
        return getEventType
    }
    
    func eventMinute() -> String {
        return getEventMinute
    }
    
    func eventTeam() -> String {
        return getEventTeam
    }
    
    func eventPlayer() -> String {
        return getEventPlayer
    }
    
    func eventPlayerId() -> String {
        return getEventPlayerId
    }
    
    func eventResult() -> String {
        return getEventResult
    }
}
