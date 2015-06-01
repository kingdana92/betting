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
        tableView.rowHeight = 200
        //tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        rControl = UIRefreshControl()
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(rControl)
        
        
        //getData.getFixtures()
        //getData.getLiveData()
        getData.gettingPercentage()
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

        // Configure the cell...
        let fixture: SoccerMatch = getData.matchArray.objectAtIndex(indexPath.row) as! SoccerMatch
        cell.homeTeamName.text = fixture.getMatchHomeTeamName
        cell.visitTeamName.text = fixture.getMatchAwayTeamName
        cell.homeTeamScore.text = fixture.getMatchHomeTeamScore
        cell.visitTeamScore.text = fixture.getMatchAwayTeamScore
        
        var dice1 = Int(arc4random_uniform(3))
        cell.backImage.image = UIImage(named: backgroundImages[1])
        cell.liveLabel.text = "   Live"

        return cell
    }

}
