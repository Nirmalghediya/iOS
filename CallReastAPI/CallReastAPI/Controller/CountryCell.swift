//
//  CountryCell.swift
//  CallReastAPI
//
//  Created by Nirmal Prajapati on 11/01/24.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    
    @IBOutlet weak var lblCapital: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
