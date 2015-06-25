//
//  CompleteBetTableViewCell.swift
//  Betting
//
//  Created by Myantel on 6/17/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class CompleteBetTableViewCell: UITableViewCell {

    //Complete
    @IBOutlet weak var homeTeamWin: UIImageView!
    @IBOutlet weak var awayTeamWin: UIImageView!
    @IBOutlet weak var homeTeamComplete: UILabel!
    @IBOutlet weak var awayTeamComplete: UILabel!
    @IBOutlet weak var homeTeamBetAmountComplete: UILabel!
    @IBOutlet weak var awayTeamBetAmountComplete: UILabel!
  
    @IBOutlet weak var withdrawBet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
