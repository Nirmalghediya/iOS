

import UIKit
import SwiftSpinner
import RSLoadingView

@available(iOS 13.0, *)

class FilterVC: UIViewController {

    @IBOutlet weak var Option_View: UIView!
    
    @IBOutlet weak var btn_Gallery: UIButton!
    
    @IBOutlet weak var btn_Camera: UIButton!
    
    // MARK: - Properties

    private lazy var cartoonGanModel: CartoonGanModel = {
        let model = CartoonGanModel()
        model.delegate = self
        return model
    }()
    
    private lazy var imagePickerController: ImagePickerController = {
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()

    private var enabled: Bool = false {
        didSet {
            btn_Gallery.isEnabled = enabled
            btn_Camera.isEnabled = enabled
        }
    }
    
    private lazy var spinner = UIActivityIndicatorView(style: .large)
    
    let loder = RSLoadingView(effectType: RSLoadingView.Effect.spinAlone)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Option_View.View4x4(view: Option_View, Redius: 20)
        navigationController?.navigationBar.isHidden = true
        //SwiftSpinner.show("Initializing model...")
        cartoonGanModel.start()
        enabled = false
        
    }
    
    @IBAction func btn_Camera(_ sender: Any)
    {
        imagePickerController.cameraAccessRequest()
    }
    
    @IBAction func btn_Gallery(_ sender: Any)
    {
        imagePickerController.photoGalleryAccessRequest()
    }
    
    @IBAction func btn_Home(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePickerController.present(parent: self, sourceType: sourceType)
    }

    private func showErrorDialog(message: String) {
        let errorDialog = ErrorDialog(message: message)
        errorDialog.present(self)
    }

    private func setupSpinner() {
        SwiftSpinner.useContainerView(view)
        SwiftSpinner.setTitleFont(Font.paragraph)
    }

    
}




// MARK: - ImagePickerControllerDelegate
@available(iOS 13.0, *)
extension FilterVC: ImagePickerControllerDelegate {
func imagePicker(_ imagePicker: ImagePickerController, canUseCamera allowed: Bool) {
    guard allowed else {
        log.error("Camera access request failed!")
        showErrorDialog(message: "We don't have access to your camera")
        return
    }

    presentImagePicker(sourceType: .camera)
}

func imagePicker(_ imagePicker: ImagePickerController, canUseGallery allowed: Bool) {
    guard allowed else {
        log.error("Gallery access request failed!")
        showErrorDialog(message: "We don't have access to your gallery")
        return
    }

    presentImagePicker(sourceType: .photoLibrary)
}

func imagePicker(_ imagePicker: ImagePickerController, didSelect image: UIImage) {
    imagePicker.dismiss {
        //SwiftSpinner.show("Processing...")
        self.loder.show(on: self.view)
        self.cartoonGanModel.process(image)
    }
}

func imagePicker(_ imagePicker: ImagePickerController, didCancel cancel: Bool) {
    if cancel { imagePicker.dismiss() }
}

func imagePicker(_ imagePicker: ImagePickerController, didFail failed: Bool) {
    if failed {
        imagePicker.dismiss()
        showErrorDialog(message: "We're having some issues to load your image!")
    }
}
}

// MARK: - CartoonGanModelDelegate
@available(iOS 13.0, *)
extension FilterVC: CartoonGanModelDelegate {
func model(_ model: CartoonGanModel, didFinishProcessing image: UIImage) {
    DispatchQueue.main.async {
        //SwiftSpinner.hide()
        self.loder.hide()
        let cartoonViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartoonVC") as! CartoonVC
        cartoonViewController.cartoonImage = image
        self.navigationController?.pushViewController(cartoonViewController, animated: true)
    }
}

func model(_ model: CartoonGanModel, didFailedProcessing error: CartoonGanModelError) {
    DispatchQueue.main.async {
        //SwiftSpinner.hide()
        self.loder.hide()
        self.showErrorDialog(message: error.localizedDescription)
    }
}

func model(_ model: CartoonGanModel, didFinishAllocation error: CartoonGanModelError?) {
    DispatchQueue.main.async {
        //SwiftSpinner.hide()
        self.loder.hide()
        guard let error = error else {
            self.enabled = true
            return
        }

        self.showErrorDialog(message: error.localizedDescription)
    }
}
}
