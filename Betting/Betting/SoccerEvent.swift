//
//  SoccerLiveScore.swift
//  Betting
//
//  Created by Myantel on 5/28/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import UIKit

class SoccerEvent {
 
    //Event Capture
    var getEventId = ""
    var getEventMatchId = ""
    var getEventType = ""
    var getEventMinute = ""
    var getEventTeam = ""
    var getEventPlayer = ""
    var getEventPlayerId = ""
    var getEventResult = ""

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