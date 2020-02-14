//
//  BarTableViewCell.swift
//  MeuPrimeiroApp
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell {
    @IBOutlet weak var ImageView: UIImageView!

    @IBOutlet weak var RatingBar: RatingBar!
    
    @IBOutlet weak var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
