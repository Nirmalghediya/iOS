
import UIKit

@available(iOS 13.0, *)
class SliderVC: UIViewController {

    @IBOutlet weak var btn_Next: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "PicsLight")

        navigationController?.navigationBar.isHidden = true
        
        btn_Next.Button4X4(btn: btn_Next, Redius: 10)
    }
   
    @IBAction func btn_Next(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StwoVC") as! StwoVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
   

}
