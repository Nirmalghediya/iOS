//
//  SlideTwo.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class SlideTwo: UIViewController {

    
    @IBOutlet weak var btn_Next: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_Next.Button4X4(btn: btn_Next, Redius: 18)
    }
    

    @IBAction func btn_Next(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
