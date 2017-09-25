//
//  PopUpWriteAllCell.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 30.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class PopUpWriteAllCell: UITableViewCell {
    
    
    @IBOutlet weak var textInCell: UITextField!
    @IBOutlet weak var butAll: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressButAll(_ sender: Any) {
        
        if(self.butAll.backgroundColor == .red){
        self.butAll.backgroundColor = .black
        }else{
            self.butAll.backgroundColor = .red
        }
        
    }
    
}
