//
//  SoccerTableViewCell.swift
//  Betting
//
//  Created by Myantel on 5/26/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class SoccerTableViewCell: UITableViewCell {

    //Score Label
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var visitTeamScore: UILabel!
    
    //Team Name Label
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var visitTeamName: UILabel!
    
    //Bet Rate
    @IBOutlet weak var homeTeamRate: UILabel!
    @IBOutlet weak var visitTeamRate: UILabel!
    
    //Status Label and Image
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    //Background Image
    //@IBOutlet weak var backImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
