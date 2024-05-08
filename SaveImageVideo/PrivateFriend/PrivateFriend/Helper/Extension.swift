//
//  Extension.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//


import Foundation
import UIKit


//// ---------------------------------------------------------------------------------------------------------- \\\\
                                                //MARK: BUTTON ANIMATION
//// ---------------------------------------------------------------------------------------------------------- \\\\


extension UIButton
{
    func BTN_Animation(btn:UIButton)
    {
        UIView.animate(withDuration: 1.3) {
            btn.center.x += 100
            btn.frame.size.width = 200
            print("Animation")
        }
    }
}

//// ---------------------------------------------------------------------------------------------------------- \\\\
                                                //MARK: VIEW ANIMATION
//// ---------------------------------------------------------------------------------------------------------- \\\\


extension UIView
{
    //// ---------------------------------------------------------------------------------------------------------- \\\\
                                                    //MARK: SIMPLE VIEW ANIMATION
    //// ---------------------------------------------------------------------------------------------------------- \\\\
    func Animation(view:UIView)
    {
        view.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)

                // Use UIView.animate to create the animation
                UIView.animate(withDuration: 0.8) {
                    // Set the final position of the view to its original position
                view.transform = .identity
                }
    }
    //// ---------------------------------------------------------------------------------------------------------- \\\\
                                                    //MARK: LEAF UP ANIMATION
    //// ---------------------------------------------------------------------------------------------------------- \\\\
    
    func LeafUP(view:UIView)
    {
        UIView .transition(with: view, duration: 1, options: .transitionCurlUp,
                     animations: { }, completion: nil)
    }
    //// ---------------------------------------------------------------------------------------------------------- \\\\
                                                    //MARK: LEAF DOWN ANIMATION
    //// ---------------------------------------------------------------------------------------------------------- \\\\
    func LeafDown(view:UIView)
    {
        UIView .transition(with: view, duration: 1, options: .transitionCurlDown,
                     animations: { }, completion: nil)
    }
    //// ---------------------------------------------------------------------------------------------------------- \\\\
                                                    //MARK: FLIP LEFT ANIMATION
    //// ---------------------------------------------------------------------------------------------------------- \\\\
    func FlipLeft(view:UIView)
    {
        UIView .transition(with: view, duration: 1, options: .transitionFlipFromLeft,
                     animations: { }, completion: nil)
    }
    //// ---------------------------------------------------------------------------------------------------------- \\\\
                                                    //MARK: FLIP RIGHT ANIMATION
    //// ---------------------------------------------------------------------------------------------------------- \\\\
    func FlipRight(view:UIView)
    {
        UIView .transition(with: view, duration: 1, options: .transitionFlipFromRight,
                     animations: { }, completion: nil)
    }
}


//// ---------------------------------------------------------------------------------------------------------- \\\\
                                                //MARK: UIBUTTON EXTENSION
//// ---------------------------------------------------------------------------------------------------------- \\\\

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
    
    

    
}

//// ---------------------------------------------------------------------------------------------------------- \\\\
                                                //MARK: UIVIEW EXTENSION
//// ---------------------------------------------------------------------------------------------------------- \\\\
extension UIView
{
    func TabBar(view:UIView,Redius:CGFloat,borderwidth:CGFloat,bordercolor:UIColor)
    {
        view.layer.cornerRadius = Redius
        view.layer.borderWidth  = borderwidth
        view.layer.borderColor = bordercolor.cgColor
    }
    
    func ViewBorder(view:UIView,borderwidth:CGFloat,bordercolor:UIColor)
    {
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
    
    func applyGradient(view:UIView,fromColor:UIColor,midColor:UIColor,toColor:UIColor)
    {
        let gragientLayer = CAGradientLayer()
        gragientLayer.frame = view.frame
        
        let fromclr = fromColor.cgColor
        let midclr = midColor.cgColor
        let toclr = toColor.cgColor
        
        gragientLayer.colors = [fromclr, midclr, toclr]
        
        view.layer.addSublayer(gragientLayer)
        
    }
    
}



//// ---------------------------------------------------------------------------------------------------------- \\\\
                                                //MARK: UIIMAGEVIEW EXTENSION
//// ---------------------------------------------------------------------------------------------------------- \\\\


extension UIImageView
{
    func Circle(img:UIImageView)
    {
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
    }
    
    func View4x4(img:UIImageView,Redius:CGFloat)
    {
        img.layer.cornerRadius = Redius
    }
    
    func ImageUpperCorner(img:UIImageView,Redius:CGFloat)
    {
        img.layer.cornerRadius = Redius
        img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func ImageBottomCorner(img:UIImageView,Redius:CGFloat)
    {
        img.layer.cornerRadius = Redius
        img.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

//// ---------------------------------------------------------------------------------------------------------- \\\\
                                                //MARK: UITEXTFIELD EXTENSION
//// ---------------------------------------------------------------------------------------------------------- \\\\

extension UITextField
{
    func Border(txt_Field:UITextField,borderwidth:CGFloat,bordercolor:UIColor)
    {
        txt_Field.layer.borderWidth  = borderwidth
        txt_Field.layer.borderColor = bordercolor.cgColor
    }
    
    func Placeholder(PlaceText:String,PlaceHolderColor:UIColor,txt_Field:UITextField)
    {
        let placeholderText = PlaceText
        let placeholderColor = PlaceHolderColor // Set your desired color
        
        
        // Create an attributed string with the desired color
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: placeholderColor
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)

        
        txt_Field.attributedPlaceholder = attributedPlaceholder
    }
}



