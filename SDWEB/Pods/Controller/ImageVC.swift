//
//  ImageVC.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 10/02/24.
//

import UIKit
import Photos

class ImageVC: UIViewController {

    
    @IBOutlet weak var Images: UIImageView!
    
    @IBOutlet weak var btn_SetWallpaper: UIButton!
    
    
    var Image = UIImage()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        Images.image = Image
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    

    @IBAction func btn_back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Download(_ sender: Any)
    {
        let alert = UIAlertController(title: "Download WallPaper", message: "Wallpaper Download Successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        if let selectedImage = Images.image {
                saveImageToPhotoLibrary(image: selectedImage)
            }
    }
    
    //MARK: Share Wallpaper
    func shareImage(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view // For iPad support
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func btn_Share(_ sender: Any)
    {
        if let imageToShare = Images.image {
                shareImage(image: imageToShare)
            }
    }
    
    //MARK: Download Wallpaper
    func saveImageToPhotoLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    
    @IBAction func btn_SetWallpaper(_ sender: Any)
    {
        
        let alert = UIAlertController(title: "Set WallPaper", message: "This Image Is Set As Wallpaper", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        
        
        if let wallpaperImage = Images.image {
                saveImageToPhotoLibrary(image: wallpaperImage)
                setWallpaper(image: wallpaperImage)
            }
        
    }
    
    //MARK: Set Wallpaper
    func setWallpaper(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    let assetPlaceholder = creationRequest.placeholderForCreatedAsset
                    let albumChangeRequest = PHAssetCollectionChangeRequest()
                    albumChangeRequest.addAssets([assetPlaceholder] as NSFastEnumeration)
                }, completionHandler: { success, error in
                    if success {
                        print("Wallpaper set successfully.")
                    } else {
                        print("Error setting wallpaper: \(error?.localizedDescription ?? "Unknown error")")
                    }
                })
            } else {
                print("Permission denied to access the photo library.")
            }
        }
    }
}
