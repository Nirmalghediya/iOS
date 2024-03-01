//
//  TableViewCell.swift
//  DictionaryTypeAPI
//
//  Created by Nirmal Prajapati on 01/03/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_state: UILabel!
    
    @IBOutlet weak var lbl_statecode: UILabel!
    
    @IBOutlet weak var lbl_Death: UILabel!
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
