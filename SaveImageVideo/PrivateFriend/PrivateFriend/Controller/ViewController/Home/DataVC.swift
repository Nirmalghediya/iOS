//
//  DataVC.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//

import UIKit
import AVFoundation


@available(iOS 13.0, *)
class DataVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var btn_add: UIButton!
    
    @IBOutlet weak var DataCollectionView: UICollectionView!
    
    
    var picker = UIImagePickerController()
    var arrRecord : [RecordEntitie] = []
    var manager = DatabaseManager()
    var isSelectedIndex = -1
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var vdoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataCollectionView.register(UINib(nibName: "ItemCVCell", bundle: nil), forCellWithReuseIdentifier: "ItemCVCell")
        
        DataCollectionView.delegate = self
        DataCollectionView.dataSource = self
        
      
        
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.arrRecord = self.manager.fetchRecords()
        self.DataCollectionView.reloadData()
    }
    

    @IBAction func btn_add(_ sender: Any) 
    {
        var alert = UIAlertController(title: "Select or take photo", message: "", preferredStyle: .alert)

        let camera = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.openCamera()
        }
        let gallery = UIAlertAction(title: "Gallery", style: .default) {
            UIAlertAction in
            self.openGallery()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
            
        }
        picker.delegate = self
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func openCamera() {
        //alert.dismiss(animated: true)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.showsCameraControls = true
            self.present(picker, animated: true)
        }
    }
    func openGallery() {
       // alert.dismiss(animated: true)
       // if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = ["public.image", "public.movie"]
            self.present(picker, animated: true)
      //  }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        if let img = info[.originalImage] as? UIImage {
            print("image-----")
            let img = info[.originalImage] as? UIImage
            addImageInCoredata(img: img!)
        } else {
            print("video-----")
            vdoURL = info[.mediaURL] as? URL
            addVdoToCoredata(url: vdoURL!)
        }
      
        print("Added successfully.")
    }

    func addImageInCoredata(img: UIImage) {
        let dt = Date()
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm:ss"//"yyyy-MM-dd HH:mm:ss"
        let ds = df.string(from: dt)
        print("time now ----> ",ds)
        
        let newRec = RecordModel(type: "img", name: "\(ds)", filename: "\(ds)")
        let rc = documentURL.appendingPathComponent("\(ds)").appendingPathExtension("png")
        
        if let data = img.pngData() {
            do{
                try data.write(to: rc)
            } catch{
                print("error")
            }
        }

        manager.addRecord(newRec)
        DispatchQueue.main.async {
            self.arrRecord = self.manager.fetchRecords()
            self.DataCollectionView.reloadData()
        }
    }
    
    func addVdoToCoredata(url: URL) {
        let dt = Date()
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm:ss"//"yyyy-MM-dd HH:mm:ss"
        let ds = df.string(from: dt)
        print("time now ----> ",ds)
        
        let newRec = RecordModel(type: "vdo", name: "\(ds)", filename: "\(ds)")
        let rc = documentURL.appendingPathComponent("\(ds)").appendingPathExtension("mov")
        
        if let data = NSData(contentsOf: url) {
            do{
                try data.write(to: rc, options: .atomic)
            } catch{
                print("error")
            }
        }

        manager.addRecord(newRec)
        DispatchQueue.main.async {
            self.arrRecord = self.manager.fetchRecords()
            self.DataCollectionView.reloadData()
        }
    }
    
    func getThumb(url:URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbimg = try imgGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbimg)
        } catch {
            print("error")
        }
        return nil
    }
    

}



@available(iOS 13.0, *)
extension DataVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRecord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DataCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCVCell", for: indexPath) as! ItemCVCell
        cell.lbl_Video.isHidden = true
        cell.label_BG.View4x4(view: cell.label_BG, Redius: 10)
        cell.View_BG.View4x4(view: cell.View_BG, Redius: 20)
        cell.Images.View4x4(img: cell.Images, Redius: 20)
        let object = self.arrRecord[indexPath.row]
        if object.type == "img" {
            let rc = documentURL.appendingPathComponent(object.filename!).appendingPathExtension("png")
            cell.Images.image = UIImage(contentsOfFile: rc.path)
        }
        else {
            cell.lbl_Video.isHidden = false
            let rc = documentURL.appendingPathComponent(object.filename!).appendingPathExtension("mov")
            if let thumb = getThumb(url: rc) {
                cell.Images.image = thumb
            }else {
                if #available(iOS 13.0, *) {
                    cell.Images.image = UIImage(systemName: "photo")
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.arrRecord[indexPath.row]
        
        if obj.type == "img" {
            let rc = documentURL.appendingPathComponent(obj.filename!).appendingPathExtension("png")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewVC") as! ViewVC
            vc.frem = rc
            vc.index = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let rc = documentURL.appendingPathComponent(obj.filename!).appendingPathExtension("mov")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewVC") as! ViewVC
            vc.frem = rc
            vc.index = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}




@available(iOS 13.0, *)
extension DataVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.1
        return CGSize(width: size, height: size * 1.1)
    }
}
