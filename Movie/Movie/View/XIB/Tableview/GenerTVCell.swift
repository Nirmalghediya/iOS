//
//  GenerTVCell.swift
//  Movies Fox
//
//  Created by Nirmal on 24/04/24.
//

import UIKit

class GenerTVCell: UITableViewCell {

    @IBOutlet weak var BG: UIView!
    
    @IBOutlet weak var lbl_gener: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
