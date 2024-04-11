
import UIKit
import CoreImage
import RSLoadingView

class BGRemoveVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var Original_View: UIView!
   
    @IBOutlet weak var Input_Image: UIImageView!
    
    @IBOutlet weak var btn_Remove: UIButton!
    
    @IBOutlet weak var lbl_Select: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    let loder = RSLoadingView(effectType: RSLoadingView.Effect.spinAlone)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Original_View.View4x4(view: Original_View, Redius: 20)
       
        
        Input_Image.View4x4(img: Input_Image, Redius: 20)
       
        
        btn_Remove.Button4X4(btn: btn_Remove, Redius: 20)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        let gc = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        gc.numberOfTapsRequired = 1
        
        Input_Image.isUserInteractionEnabled = true
        Input_Image.addGestureRecognizer(gc)
        
        if Input_Image.image == nil
        {
            lbl_Select.isHidden = false
        }
        else
        {
            lbl_Select.isHidden = true
        
        }
    }
    
    /// PickImage: 
    @objc func pickImage() {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btn_Remove(_ sender: Any)
    {
        self.loder.show(on: view)
        
        if Input_Image.image != nil {
            if let cgImg = Input_Image.image!.segmentation(){
                let filter = GraySegmentFilter()
                filter.inputImage = CIImage.init(cgImage: (Input_Image.image?.cgImage!)!)
                filter.maskImage = CIImage.init(cgImage: cgImg)
                let output = filter.value(forKey:kCIOutputImageKey) as! CIImage
                let ciContext = CIContext(options: nil)
                let cgImage = ciContext.createCGImage(output, from: output.extent)!
                Input_Image.image = UIImage(cgImage: cgImage)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5){
            self.loder.hide()
                }
    }
    
    @IBAction func btn_Back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_Download(_ sender: Any)
    {
        let alert = UIAlertController(title: "Download Picture", message: "Picture Download Successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        if let selectedImage = Input_Image.image {
                saveImageToPhotoLibrary(image: selectedImage)
            }
    }
    
    
    
    // Function to handle when the user selects an image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                Input_Image.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        // Function to handle when the user cancels image picker
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    func saveImageToPhotoLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
   
   
}

