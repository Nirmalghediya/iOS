//
//  FirstCell.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class FirstCell: UICollectionViewCell {

    
    @IBOutlet weak var Back_View: UIView!
    
    @IBOutlet weak var Images: UIImageView!
    
    
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
                self?.Images.image = image
            }
        }.resume()
    }
}
