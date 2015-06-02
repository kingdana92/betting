//
//  SoccerTableViewController.swift
//  Betting
//
//  Created by Myantel on 5/26/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
import Parse

var getData = SoccerData()
var rControl : UIRefreshControl!

class SoccerTableViewController: UITableViewController {
    
    var backgroundImages = ["background 1.png", "background 2.png", "background 3.png"]
    var activeRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.rowHeight = 160
        //tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        rControl = UIRefreshControl()
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(rControl)
        
        
        getData.getFixtures()
        getData.getLiveData()
    }

    func refresh(sender:AnyObject)
    {
        getData.getFixtures()
        getData.getLiveData()
        tableView.reloadData()
        //rControl.endRefreshing()
    
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

        let homeTeamTotal = fixture.getMatchLocalTeamTotal.toInt()
        let awayTeamTotal = fixture.getMatchVisitorTeamTotal.toInt()
        let total = homeTeamTotal! + awayTeamTotal!
        var homeRate = 0
        var awayRate = 0
        if total > 0 {
            homeRate = homeTeamTotal!/total
            awayRate = awayTeamTotal!/total
            cell.homeTeamRate.text = "\(homeRate)%"
            cell.visitTeamRate.text = "\(awayRate)%"
        } else {
            cell.homeTeamRate.text = "0%"
            cell.visitTeamRate.text = "0%"
        }
        //Configure the cell...
        cell.homeTeamName.text = fixture.getMatchHomeTeamName
        cell.visitTeamName.text = fixture.getMatchAwayTeamName
        cell.homeTeamScore.text = fixture.getMatchHomeTeamScore
        cell.visitTeamScore.text = fixture.getMatchAwayTeamScore
        
        
        var dice1 = Int(arc4random_uniform(3))
        //cell.backImage.image = UIImage(named: backgroundImages[1])
        cell.liveLabel.text = "   Live"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("soccerDetail", sender: self)
    }

}
