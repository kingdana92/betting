//
//  DetailViewController.swift
//  Betting
//
//  Created by Myantel on 6/2/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Home Team
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var homeTeamRate: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    
    //Away Team
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var awayTeamRate: UILabel!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    
    //Live Status
    @IBOutlet weak var liveEventTime: UILabel!
    @IBOutlet weak var liveEventImage: UIImageView!
    //TableView
    @IBOutlet weak var detailTableView: UITableView!
    //Commentary
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.delegate = self
        detailTableView.reloadData()
        
        let fixture: SoccerMatch = getData.matchArray.objectAtIndex(activeRow) as! SoccerMatch
        
        //Home Team
        homeTeamScore.text = fixture.getMatchHomeTeamScore
        homeTeamName.text = fixture.getMatchHomeTeamName
        //Away Team
        awayTeamScore.text = fixture.getMatchAwayTeamScore
        awayTeamName.text = fixture.getMatchAwayTeamName
        
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
            homeTeamRate.text = String(stringInterpolationSegment: roundedHome) + "%"
            awayTeamRate.text = String(stringInterpolationSegment: roundedAway) + "%"
        } else {
            homeTeamRate.text = "0%"
            awayTeamRate.text = "0%"
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getData.matchArray.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.homeTeamEventPlayer.text = "Dana"
         
        return cell
    }

}
