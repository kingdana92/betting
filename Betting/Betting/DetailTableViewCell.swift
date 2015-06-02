//
//  DetailTableViewCell.swift
//  Betting
//
//  Created by Myantel on 6/2/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamEventImgae: UIView!
    @IBOutlet weak var homeTeamEventPlayer: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var awayTeamEventPlayer: UILabel!
    @IBOutlet weak var awayTeamEventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
