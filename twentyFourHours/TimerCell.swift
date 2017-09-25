//
//  TimerCell.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 31.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timerTime: UILabel!
    
    var timeOut = 20
    var timer: Timer!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        timerTime.text = "20"
        
    timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(TimerCell.timerRuning), userInfo: nil, repeats: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func timerRuning(){
        timeOut -= 1
        timerTime.text = "\(timeOut)"
        if (timeOut == 0)
        {
            timeOut = 21
        }
    }
    
}
