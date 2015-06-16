//
//  MyBetTableViewController.swift
//  Betting
//
//  Created by Myantel on 6/16/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class MyBetTableViewController: UITableViewController {
    let data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]
    let headerTitles = ["Some Data 1", "KickAss"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return data[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("betCell", forIndexPath: indexPath) as! UITableViewCell
            return cell

        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("imcomBetCell", forIndexPath: indexPath) as! UITableViewCell
            return cell

        }
        
        return cell

    }
    

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
