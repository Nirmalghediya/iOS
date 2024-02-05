//
//  CostomElement.swift
//  Design
//
//  Created by Nirmal Prajapati on 13/01/24.
//

import UIKit

extension UIView
{
    func RoundCorner(view:UIView,Redius:CGFloat)
    {
        view.layer.cornerRadius = Redius
    }
    
    func TopCorner(view:UIView,Redius:CGFloat)
    {
        view.layer.cornerRadius = Redius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func BottomCorner(view:UIView,Redius:CGFloat)
    {
        view.layer.cornerRadius = Redius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
