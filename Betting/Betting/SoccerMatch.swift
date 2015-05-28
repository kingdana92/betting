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
    
    var getMatchId = 0
    var getMatchCompId = 0
    var getMatchDate = ""
    var getMatchFormattedDate = ""
    var getMatchStatus = ""
    var getMatchTime = 0
    var getMatchCommentaryAvailable = ""
    var getMatchHomeTeamId = 0
    var getMatchHomeTeamName = ""
    var getMatchHomeTeamScore = 0
    var getMatchAwayTeamId = 0
    var getMatchAwayTeamName = ""
    var getMatchAwayTeamScore = 0
    var getMatchHalfTimeScore = ""
    var getMatchFullTimeScore = ""
    var getMatchExtraTimeScore = ""
    
    func getData() {
        
    }
    
    func matchId() -> Int {
        return getMatchId
    }
    
    func matchCompId() -> Int {
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
    
    func matchTime() -> Int {
        return getMatchTime
    }
    
    func matchCommentaryAvailable() -> String {
        return getMatchCommentaryAvailable
    }
    
    func matchHomeTeamId() -> Int {
        return getMatchHomeTeamId
    }
    
    func matchHomeTeamName() -> String  {
        return getMatchHomeTeamName
    }
    
    func matchHomeTeamScore() -> Int {
        return getMatchHomeTeamScore
    }
    
    func matchAwayTeamId() -> Int {
        return getMatchAwayTeamId
    }
    
    func matchAwayTeamName() -> String {
        return getMatchAwayTeamName
    }
    
    func matchAwayTeamScore() -> Int {
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
}