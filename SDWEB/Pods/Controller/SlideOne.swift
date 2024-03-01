//
//  SlideOne.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class SlideOne: UIViewController {

    @IBOutlet weak var Text_View: UIView!
    
    
    @IBOutlet weak var btn_Next: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        btn_Next.Circle(btn: btn_Next)
        Text_View.View4x4(view: Text_View, Redius: 20)
    }
    
    @IBAction func btn_Next(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SlideTwo") as! SlideTwo
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
