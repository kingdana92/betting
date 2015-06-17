//
//  IncompleteBetTableViewCell.swift
//  Betting
//
//  Created by Myantel on 6/17/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class IncompleteBetTableViewCell: UITableViewCell {

    //Labels and Buttons
    
    //Incomplete
    @IBOutlet weak var homeTeamIncomplete: UILabel!
    @IBOutlet weak var awayTeamIncomplete: UILabel!
    @IBOutlet weak var homeTeamBetAmountIncomplete: UILabel!
    @IBOutlet weak var awayTeamBetAmountIncomplete: UILabel!
    
    @IBOutlet weak var retryLabel: UIButton!
    @IBOutlet weak var refundLabel: UIButton!
      
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
