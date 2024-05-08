//
//  WatchListTVCell.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 18/04/24.
//

import UIKit

class WatchListTVCell: UITableViewCell {

    
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var lbl_Year: UILabel!
    
    @IBOutlet weak var lbl_extract: UILabel!
    
    @IBOutlet weak var Movie_Image: UIImageView!
    
    @IBOutlet weak var BG: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
