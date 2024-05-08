//
//  SecondVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 17/04/24.
//

import UIKit

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func btn_Next(_ sender: Any) 
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
