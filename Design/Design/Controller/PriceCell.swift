//
//  PriceCell.swift
//  Design
//
//  Created by Nirmal Prajapati on 13/01/24.
//

import UIKit

class PriceCell: UITableViewCell {

    
    @IBOutlet weak var LogoImage: UIImageView!
    
    @IBOutlet weak var lblSuper: UILabel!
    
    @IBOutlet weak var lblPersentage: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
