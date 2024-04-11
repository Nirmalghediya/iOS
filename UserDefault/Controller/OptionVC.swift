

import UIKit

@available(iOS 13.0, *)
class OptionVC: UIViewController {

    @IBOutlet weak var View_BG: UIView!
    
    @IBOutlet weak var btn_Edit: UIButton!
    
    @IBOutlet weak var btn_Anime: UIButton!
    
    @IBOutlet weak var btn_Saved: UIButton!
    
    @IBOutlet weak var Remove_BG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        View_BG.Animation(view: View_BG)
        View_BG.View4x4(view: View_BG, Redius: 20)
        
        btn_Edit.Button4X4(btn: btn_Edit, Redius: 18)
        btn_Anime.Button4X4(btn: btn_Anime, Redius: 18)
        btn_Saved.Button4X4(btn: btn_Saved, Redius: 18)
       
        Remove_BG.View4x4(view: Remove_BG, Redius: 20)
        
        let tapBG = UITapGestureRecognizer(target: self, action: #selector(Nav))
        tapBG.numberOfTapsRequired = 1
        Remove_BG.addGestureRecognizer(tapBG)
    }
    
    @objc func Nav() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BGRemoveVC") as! BGRemoveVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func btn_Edit(_ sender: Any)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditVC") as! EditVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Anime(_ sender: Any)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Saved(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewVC") as! ViewVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    

}
