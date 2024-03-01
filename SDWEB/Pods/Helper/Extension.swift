//
//  Extension.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import Foundation
import UIKit




//---------------------------------
// MARK: Customize UIButton
//---------------------------------





extension UIButton
{
    func ButtonShadow(btn:UIButton,shadowColor:UIColor,ShadowRedius:CGFloat,SadowOpacity:Float)
    {
        btn.layer.shadowColor = shadowColor.cgColor
        btn.layer.shadowRadius = ShadowRedius
        btn.layer.shadowOpacity = SadowOpacity
    }
    
    func Circle(btn:UIButton)
    {
        btn.layer.cornerRadius = btn.frame.size.width/2
        btn.clipsToBounds = true
    }
    
    func Button4X4(btn:UIButton,Redius:CGFloat)
    {
        btn.layer.cornerRadius = Redius
    }
    
    func Border(btn:UIButton,Width:CGFloat,Color:UIColor)
    {
        btn.layer.borderWidth = Width
        btn.layer.borderColor = Color.cgColor
    }
    
    
//    func GreenDaseGradient(btn:UIButton)
//    {
//
//        let color = [UIColor(hex: "FFFF90"),UIColor(hex: "1EFF00"),UIColor(hex: "00BFFF")]
//
//        btn.setGradientBackgroundColors(color, direction: .toLeft, for: UIControl.State.normal)
//        btn.layer.cornerRadius = btn.frame.size.height/2
//        //btn.layer.cornerRadius = 18
//        btn.layer.masksToBounds = true
//    }
    
    
//    func PurpleBaseGradient(btn:UIButton)
//    {
//
//        let color = [UIColor(hex: "3BFF5359"),UIColor(hex: "EE00FFB3"),UIColor(hex: "3600FFFC")]
//        btn.setGradientBackgroundColors(color, direction: .toLeft, for: UIControl.State.normal)
//        btn.layer.cornerRadius = btn.frame.size.height/2
//        //btn.layer.cornerRadius = 18
//        btn.layer.masksToBounds = true
//    }
//
//    func BlueBaseGradient(btn:UIButton)
//    {
//
//        let color = [UIColor(hex: "00FFE6"),UIColor(hex: "0090D4"),UIColor(hex: "12FF87")]
//        btn.setGradientBackgroundColors(color, direction: .toLeft, for: UIControl.State.normal)
//        btn.layer.cornerRadius = btn.frame.size.height/2
//        //btn.layer.cornerRadius = 18
//        btn.layer.masksToBounds = true
//    }
    
}

//---------------------------------
// MARK: Customize UIView
//---------------------------------
extension UIView
{
    func TabBar(view:UIView,Redius:CGFloat,borderwidth:CGFloat,bordercolor:UIColor)
    {
        view.layer.cornerRadius = Redius
        view.layer.borderWidth  = borderwidth
        view.layer.borderColor = bordercolor.cgColor
    }
    
    
    
    func Circle(view:UIView)
    {
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
    }
    
    
    func View4x4(view:UIView,Redius:CGFloat)
    {
        view.layer.cornerRadius = Redius
    }
    
    func ViewUpperCorner(view:UIView,Redius:CGFloat)
    {
        view.layer.cornerRadius = Redius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func ViewBottomCorner(view:UIView,Redius:CGFloat)
    {
        view.layer.cornerRadius = Redius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func ViewShadow(view:UIView,shadowColor:UIColor,ShadowRedius:CGFloat,SadowOpacity:Float)
    {
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowRadius = ShadowRedius
        view.layer.shadowOpacity = SadowOpacity
    }
    
    
}



//---------------------------------
// MARK: Customize UIImage
//---------------------------------


extension UIImageView
{
    func Circle(img:UIImageView)
    {
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
    }
}

//extension AnimatedGradientView{
//    func AnimatedGradient(view:AnimatedGradientView)
//    {
//        view.direction = .downRight
//        view.animationValues = [(colors: ["#FFFF90", "#1EFF00", "#00BFFF"], .downRight, .axial),(colors: ["#2BC0E4", "#EAECC6"], .downLeft, .axial),(colors: ["#003973", "#E5E5BE"], .down, .axial)]
//        view.layer.cornerRadius = 20
//    }
    
//    ,
//    ,//
//    ,
//





