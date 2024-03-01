//
//  UIImageview + Extensions.swift
//  MVVMProduct
//
//  Created by Nirmal Prajapati on 14/02/24.
//

import UIKit
import Kingfisher

extension UIImageView
{
    func setImage(with urlString:String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let responce = KF.ImageResource(downloadURL: url,cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: responce)
    }
    
}

