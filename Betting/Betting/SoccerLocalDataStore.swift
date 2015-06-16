//
//  SoccerLocalDataStore.swift
//  Betting
//
//  Created by Myantel on 6/16/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import Foundation
import Parse

class SoccerLocalDataStore {
    
    func queryForUpload(matchID : String) {
        let query = PFQuery(className: "betList")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        if object["matchId"] as! String == matchID {
                            object.unpinInBackground()
                        }
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func deleteFromLocal(matchID : String) {
        let query = PFQuery(className: "betList")
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        if object["matchId"] as! String == matchID {
                            object.unpinInBackground()
                        }
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
}