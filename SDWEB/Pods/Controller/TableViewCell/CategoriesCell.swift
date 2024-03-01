//
//  CategoriesCell.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var Images: UIImageView!
    
    @IBOutlet weak var lbl_Text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
