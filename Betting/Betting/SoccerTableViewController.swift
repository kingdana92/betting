//
//  SoccerTableViewController.swift
//  Betting
//
//  Created by Myantel on 5/26/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
import Parse

var activeRow = 0

var rControl : UIRefreshControl!
var getData = SoccerData()
class SoccerTableViewController: UITableViewController {
    var backgroundImages = ["background 1.png", "background 2.png", "background 3.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: notifKey, object: nil)

        //Pull to refresh control
        rControl = UIRefreshControl()
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(rControl)
        
        
        //NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
        getData.getFixtures()
        tableView.reloadData()
        
        //getData.getLiveData()
        //getData.uploadBet("qs8RcHexOo", matchId: "2001950", teamId: "0", teamId2: "10772", betAmount: "700")
    }

    func refresh(sender:AnyObject)
    {
        getData.getFixtures() 
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func handleTimer(timer: NSTimer) {
        getData.getFixtures()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return getData.matchArray.count
    }

    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("soccerCell", forIndexPath: indexPath) as! SoccerTableViewCell
        
        let fixture: SoccerMatch = getData.matchArray.objectAtIndex(indexPath.row) as! SoccerMatch
        
        let homeTeamTotal = (fixture.getMatchLocalTeamTotal as NSString).doubleValue
        let awayTeamTotal = (fixture.getMatchVisitorTeamTotal as NSString).doubleValue
        let total = (fixture.getMatchPoolTotal as NSString).doubleValue
        
        //Getting Rate
        if total > 0 {
            let homeRate = homeTeamTotal/total
            let awayRate = awayTeamTotal/total
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)
            let roundedHome = NSInteger((round(homeRate * multiplier) / multiplier) * 100)
            let roundedAway = NSInteger((round(awayRate * multiplier) / multiplier) * 100)
            cell.homeTeamRate.text = String(stringInterpolationSegment: roundedHome) + "%"
            cell.visitTeamRate.text = String(stringInterpolationSegment: roundedAway) + "%"
        } else {
            cell.homeTeamRate.text = "0%"
            cell.visitTeamRate.text = "0%"
        }
        
        //Home and Away Labels
        cell.homeTeamName.text = fixture.getMatchHomeTeamName
        cell.visitTeamName.text = fixture.getMatchAwayTeamName
        cell.homeTeamScore.text = fixture.getMatchHomeTeamScore
        cell.visitTeamScore.text = fixture.getMatchAwayTeamScore
        
        //Live Status
        if fixture.live == false {
            cell.statusImage.hidden = true
            cell.liveLabel.text = fixture.getUpcomingTime()
        } else {
            cell.statusImage.hidden = false
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("soccerDetail", sender: self)
        activeRow = indexPath.row
    }

}
