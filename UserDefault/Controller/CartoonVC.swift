
import UIKit

class CartoonVC: UIViewController {

    @IBOutlet weak var Cartoon_Image: UIImageView!
    
    @IBOutlet weak var Option_View: UIView!
    
    @IBOutlet weak var SelectPhotolbl: UILabel!
    
    var cartoonImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Cartoon_Image.image = cartoonImage
        Option_View.View4x4(view: Option_View, Redius: 20)
        
    }
    
   
    
    @IBAction func btn_Back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Save(_ sender: Any)
    {
        let alert = UIAlertController(title: "Download Picture", message: "Picture Download Successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        if let selectedImage = Cartoon_Image.image {
                saveImageToPhotoLibrary(image: selectedImage)
            }
    }
    
    @IBAction func btn_Share(_ sender: Any)
    {
        if let imageToShare = Cartoon_Image.image {
                shareImage(image: imageToShare)
            }
    }
    
    func shareImage(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view // For iPad support
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        present(activityViewController, animated: true, completion: nil)
    }
    
    func saveImageToPhotoLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
   
}
