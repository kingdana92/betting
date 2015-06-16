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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: notifKey, object: nil)
        
        //Pull to refresh control
        rControl = UIRefreshControl()
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(rControl)
        
        
        //NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
        
        LoadingOverlay.shared.showOverlay(self.view)

        getData.getFixtures()
        
        tableView.tableFooterView = UIView()
    }

    func refresh(sender:AnyObject)
    {
        getData.getFixtures()
    }
    
    func reloadTable() {
        LoadingOverlay.shared.hideOverlayView()
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
        //tableView.reloadData()
        
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

        //Home and Away Images
        
        //Comp Label
        var compName = compList[fixture.getMatchCompId]
        cell.compLabel.text = compName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activeRow = indexPath.row
        
        let fixture: SoccerMatch = getData.matchArray.objectAtIndex(indexPath.row) as! SoccerMatch
        betMatchHomeTeamId = fixture.getMatchHomeTeamId
        betMatchAwayTeamId = fixture.getMatchAwayTeamId
        teamName[1] = fixture.getMatchHomeTeamName
        teamName[2] = fixture.getMatchAwayTeamName
        betMatchId = fixture.getMatchId
        if fixture.getUpcomingTime().toInt() < 0 {
            //performSegueWithIdentifier("soccerDetail", sender: self)
            performSegueWithIdentifier("betPage", sender: self)
        } else {
            performSegueWithIdentifier("betPage", sender: self)
        }
    }

    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells()
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as! UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as! UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
}
