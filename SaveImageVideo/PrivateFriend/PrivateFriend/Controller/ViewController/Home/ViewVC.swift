//
//  ViewVC.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer


@available(iOS 13.0, *)
class ViewVC: UIViewController {

    @IBOutlet weak var btn_remove: UIButton!
    
    @IBOutlet weak var btn_share: UIButton!
    
    @IBOutlet weak var Image: UIImageView!
    
    var frem = URL(string: "")
    var index = -1
    
    var arrRecord : [RecordEntitie] = []
    var manager = DatabaseManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_share.Button4X4(btn: btn_share, Redius: 20)
        btn_remove.Button4X4(btn: btn_remove, Redius: 20)
        
        
        
        self.arrRecord = self.manager.fetchRecords()
        
        let obj = arrRecord[index]
        if obj.type == "img" {
            Image.image = UIImage(contentsOfFile: frem!.path)
        } else {
            let player = AVPlayer(url: frem!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = Image.frame
            self.view.layer.addSublayer(playerLayer)
            player.play()
            
        }
    }
    
    @IBAction func btn_back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_share(_ sender: Any) 
    {
        let obj = arrRecord[index]
        if obj.type == "img" {
            guard let sIMG = Image.image else {
                print("error to save")
                return
            }
            UIImageWriteToSavedPhotosAlbum(sIMG, nil, nil, nil)
            
        } else {
            UISaveVideoAtPathToSavedPhotosAlbum(frem!.relativePath, self, nil, nil)
           
        }
        
    }
    
    @IBAction func btn_remove(_ sender: Any) 
    {
        manager.deleteRecord(recordEntity: self.arrRecord[index])
        self.navigationController?.popViewController(animated: true)
    }
    
}
