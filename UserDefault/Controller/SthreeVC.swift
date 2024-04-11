

import UIKit

@available(iOS 13.0, *)
class SthreeVC: UIViewController {

    
    
    @IBOutlet weak var btn_Next: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_Next.Button4X4(btn: btn_Next, Redius: 10)
        
    }
    
    @IBAction func btn_Next(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OptionVC") as! OptionVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
   

}
