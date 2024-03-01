//
//  ProductCell.swift
//  MVVMProduct
//
//  Created by Nirmal Prajapati on 14/02/24.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var rateButton: UIButton!
    
    @IBOutlet weak var productDiscription: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var productImage: UIImageView!
    
    
    var product: Product? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        productImage.layer.cornerRadius = 10
        self.productBackgroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration()
    {
        guard let product else { return }
        productTitle.text = product.title
        productCategory.text = product.category
        productDiscription.text = product.description
        productPrice.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImage.setImage(with: product.image)
        
    }
    
    
}
