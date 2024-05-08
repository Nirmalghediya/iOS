//
//  IntroOne.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//

import UIKit

@available(iOS 13.0, *)
class IntroOne: UIViewController {

    @IBOutlet weak var View_BG: UIView!
    
    @IBOutlet weak var btn_Next: UIButton!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "PrivateFriend")
        
        navigationController?.navigationBar.isHidden = true
        
        
        
        View_BG.Circle(view: View_BG)
        btn_Next.Circle(btn: btn_Next)
        

        
    }
    
    @IBAction func btn_Next(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IntroTwo") as! IntroTwo
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
