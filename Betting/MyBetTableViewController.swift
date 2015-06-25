//
//  MyBetTableViewController.swift
//  Betting
//
//  Created by Myantel on 6/16/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
import Parse

class MyBetTableViewController: UITableViewController {
    var firstSection = 0
    var secondSection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        tableView.allowsSelection = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: "retryDone", object: nil)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "betList")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            self.firstSection = objects!.count
        }
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        //Incomplete Number of Row
        if section == 0 {
            return firstSection
        }
        //Complete Number of Row
        if section == 1 {
            
            return 1
        }
        
        return 1
    }



    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("incomBetCell", forIndexPath: indexPath) as! IncompleteBetTableViewCell
            //Incomplete Cell Section
            
            //Button
            cell.retryLabel.tag = indexPath.row
            cell.refundLabel.tag = indexPath.row
            cell.retryLabel.addTarget(self, action: "retryBet:", forControlEvents: .TouchUpInside)
            cell.refundLabel.addTarget(self, action: "refundBet:", forControlEvents: .TouchUpInside)
            
            //Query
            let query = PFQuery(className: "betList")
            query.fromLocalDatastore()
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        var object = objects[indexPath.row]
                        cell.homeTeamIncomplete.text = object["homeTeam"] as? String
                        cell.awayTeamIncomplete.text = object["awayTeam"] as? String
                        if object["teamId"] as? String == "0" {
                            cell.awayTeamBetAmountIncomplete.text = object["betAmount"] as? String
                            
                        } else {
                            cell.homeTeamBetAmountIncomplete.text = object["betAmount"] as? String
                            
                        }
                    }
                } else {
                    // Log details of the failure
                    println("Error: \(error!) \(error!.userInfo!)")
                }
            }
            
            return cell

        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("betCell", forIndexPath: indexPath) as! CompleteBetTableViewCell
            //Complete Cell Section
            
            cell.withdrawBet.tag = indexPath.row
            cell.withdrawBet.addTarget(self, action: "withdrawBet:", forControlEvents: .TouchUpInside)
            
            
            
            
            
            return cell
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if firstSection == 0 {
                return nil
            }
            return "Incomplete Bet"
        }
        if section == 1 {
            if firstSection == 0 {
                return nil
            }
            return "Complete Bet"
        }
        return nil
    }
    
    func calculatetime(upcomingMatchTime : String) -> String {
        var upcomingTime = ""
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
            upcomingTime = "\(hours)hr 0\(correctMinute)min"
            return upcomingTime
        } else {
            upcomingTime = "\(hours)hr \(correctMinute)min"
            return upcomingTime
        }
        
    }
    @IBAction func retryBet(sender: UIButton) {
        LoadingOverlay.shared.showOverlay(self.view)
        println("retry")
        let query = PFQuery(className: "betList")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    var object = objects[sender.tag]
                    var user = object["userObjectId"] as! String
                    var match = object["matchId"] as! String
                    var homeTeam = object["teamId"] as! String
                    var awayTeam = object["teamId2"] as! String
                    var amount = object["betAmount"] as! String
                    var paypal = object["paypalId"] as! String
                    getData.uploadBet(user, matchId: match, teamId: homeTeam, teamId2: awayTeam, betAmount: amount, payPalId: paypal, from: "retry", object : object)
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }

    }

    @IBAction func refundBet(sender: UIButton) {
        println("refund")
        LoadingOverlay.shared.showOverlay(self.view)
        let query = PFQuery(className: "betList")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    var object = objects[sender.tag]
                    var user = object["userObjectId"] as! String
                    var match = object["matchId"] as! String
                    var homeTeam = object["teamId"] as! String
                    var awayTeam = object["teamId2"] as! String
                    var amount = object["betAmount"] as! String
                    var paypal = object["paypalId"] as! String
                    getData.refundBet(user, matchId: match, paypalId: paypal)
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    @IBAction func withdrawBet(sender: UIButton) {
        println("withdraw")
//        LoadingOverlay.shared.showOverlay(self.view)
//        let query = PFQuery(className: "betList")
//        query.fromLocalDatastore()
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [AnyObject]?, error: NSError?) -> Void in
//            if error == nil {
//                if let objects = objects as? [PFObject] {
//                    var object = objects[sender.tag]
//                    var user = object["userObjectId"] as! String
//                    var match = object["matchId"] as! String
//                    var homeTeam = object["teamId"] as! String
//                    var awayTeam = object["teamId2"] as! String
//                    var amount = object["betAmount"] as! String
//                    var paypal = object["paypalId"] as! String
//                    getData.withdrawBet(user, matchId: match, paypalId: paypal)
//                }
//            } else {
//                // Log details of the failure
//                println("Error: \(error!) \(error!.userInfo!)")
//            }
//        }
    }
    
    
    func reloadTable() {
        LoadingOverlay.shared.hideOverlayView()
        tableView.reloadData()
    }
}
