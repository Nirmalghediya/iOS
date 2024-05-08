//
//  FirstVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 17/04/24.
//

import UIKit

class FirstVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "Moviefox")
        navigationController?.navigationBar.isHidden = true
      
    }
    
    @IBAction func btn_Nect(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
