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
    
    var getEventId = 0
    var getEventMatchId = 0
    var getEventType = ""
    var getEventMinute = 0
    var getEventTeam = ""
    var getEventPlayer = ""
    var getEventPlayerId = 0
    var getEventResult = ""
    
    func eventId() -> Int {
        return getEventId
    }
    
    func eventMatchId() -> Int {
        return getEventMatchId
    }
    
    func eventType() -> String {
        return getEventType
    }
    
    func eventMinute() -> Int {
        return getEventMinute
    }
    
    func eventTeam() -> String {
        return getEventTeam
    }
    
    func eventPlayer() -> String {
        return getEventPlayer
    }
    
    func eventPlayerId() -> Int {
        return getEventPlayerId
    }
    
    func eventResult() -> String {
        return getEventResult
    }
}
