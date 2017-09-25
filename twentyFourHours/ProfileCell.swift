//
//  ProfileCell.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 03.04.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var labelCoins: UILabel!
    @IBOutlet weak var coinsBut: UIButton!
    
    var coins = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelCoins.text = String(coins)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func pressCoinsBut(_ sender: Any) {
        coins -= 1
        labelCoins.text = String(coins)
    }
}
