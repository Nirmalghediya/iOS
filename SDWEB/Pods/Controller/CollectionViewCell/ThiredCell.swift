//
//  ThiredCell.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit
import SDWebImage

class ThiredCell: UICollectionViewCell {

    
    @IBOutlet weak var Images: UIImageView!
    
    @IBOutlet weak var Back_View: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with urlString:String)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                //self?.Images.image = image
                self?.Images.sd_setImage(with: url, placeholderImage: UIImage(named: "setwall"))
            }
        }.resume()
    }

}


