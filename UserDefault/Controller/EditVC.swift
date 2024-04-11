

import UIKit
import ZLImageEditor

class EditVC: UIViewController {

    
    @IBOutlet weak var edit_Image: UIImageView!
    
    @IBOutlet weak var selectPhotoLbl: UILabel!
    
    @IBOutlet weak var View_BG: UIView!
    
    var resultImageView: UIImageView!
    var originalImage: UIImage?
    var resultImageEditModel: ZLEditImageModel?
    var drawingId: String?
    var imageGot: UIImage?
    
    var vc: ZLEditImageViewController!
    var drawingList: [ImageModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        View_BG.View4x4(view: View_BG, Redius: 20)
        
        let gc = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        gc.numberOfTapsRequired = 1
        
        edit_Image.isUserInteractionEnabled = true
        edit_Image.addGestureRecognizer(gc)
        
        if let imagegot = imageGot {
            setImage(img: imagegot)
        }
        
        ZLImageEditorConfiguration.default()
            .editImageTools([.draw, .clip, .imageSticker, .textSticker, .mosaic, .filter, .adjust])
            .adjustTools([.brightness, .contrast, .saturation])
       
        
       
    }
    
    func setImage(img: UIImage) {
        self.selectPhotoLbl.isHidden = true
        self.originalImage = img
        self.edit_Image.image = img
        self.edit_Image.backgroundColor = .clear
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        showDetailViewController(picker, sender: nil)
    }

    
    @IBAction func btn_Back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Save(_ sender: Any)
    {
        guard selectPhotoLbl.isHidden else {
            presentAlert(title: "", message: "Please select image")
            return
        }
        
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "savedDrawings") != nil {
            let decoded  = userDefaults.data(forKey: "savedDrawings")
            do {
                let list = try JSONDecoder().decode([ImageModel].self, from: decoded!)
                drawingList = list
            } catch let error {
                let alert = UIAlertController(title: "Error saving File Try again", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Error \(error.localizedDescription)")
            }
        } else {
            drawingList = [ImageModel]()
        }
        
        let img = edit_Image.image!
        guard let data = img.pngData() else {
            // Show alert error saving drawing.
            return
        }
        

        
        if let row = drawingList!.firstIndex(where: {$0.id == drawingId}) {
            drawingList![row] = ImageModel(data: data, id: drawingId ?? "")
        }
        
        if !drawingList!.contains(where: { $0.id == drawingId ?? ""}) {
            drawingList?.append(ImageModel(data: data, id: UUID().uuidString))
        }
        
        do {
            let encodeData = try JSONEncoder().encode(drawingList!)
                UserDefaults.standard.set(encodeData, forKey: "savedDrawings")
            let alert = UIAlertController(title: "Saved", message: "Image Saved", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
        } catch let error {
            let alert = UIAlertController(title: "Error saving File Try again", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Error \(error.localizedDescription)")
        }
    }
    
    @IBAction func btn_Edit(_ sender: Any)
    {
        guard selectPhotoLbl.isHidden else {
            presentAlert(title: "", message: "Please select image")
            return
        }
        
        guard let originalImage else { return }
        
        self.editImage(originalImage, editModel: resultImageEditModel)

    }
    
    @IBAction func btn_Share(_ sender: Any)
    {
        guard selectPhotoLbl.isHidden else {
            presentAlert(title: "", message: "Please select image")
            return
        }
        saveImage(image: edit_Image.image!)
        
        
    }
    
    
    @IBAction func TapGesture(_ sender: UITapGestureRecognizer)
    {
        
    }
    
    @IBAction func btn_DownLoad(_ sender: Any)
    {
        guard selectPhotoLbl.isHidden else {
            presentAlert(title: "", message: "Please select image")
            return
        }
       
        
        do {
            
            let alert = UIAlertController(title: "Download Picture", message: "Picture Download Successfully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            if let selectedImage = edit_Image.image {
                    saveImageToPhotoLibrary(image: selectedImage)
                }
            
        } catch let error {
            let alert = UIAlertController(title: "Error saving File Try again", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Error \(error.localizedDescription)")
        }
    }
    
    
    func saveImage(image: UIImage) {
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func editImage(_ image: UIImage, editModel: ZLEditImageModel?) {
        ZLEditImageViewController.showEditImageVC(parentVC: self, image: image, editModel: editModel) { [weak self] resImage, editModel in
//            self?.resultImageView.image = resImage
            self?.edit_Image.image = resImage
            self?.resultImageEditModel = editModel
        }
    }

    func saveImageToPhotoLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

extension EditVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            guard var image = info[.originalImage] as? UIImage else { return }
            let w = min(1500, image.zl.width)
            let h = w * image.zl.height / image.zl.width
            image = image.zl.resize(CGSize(width: w, height: h)) ?? image
            self.resultImageEditModel = nil
            self.setImage(img: image)
            self.editImage(image, editModel: nil)
        }
    }
}
