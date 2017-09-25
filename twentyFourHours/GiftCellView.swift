//
//  GiftCellView.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 30.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class GiftCellView: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

}
