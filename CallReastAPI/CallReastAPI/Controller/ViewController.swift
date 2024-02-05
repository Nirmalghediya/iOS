//
//  ViewController.swift
//  CallReastAPI
//
//  Created by Nirmal Prajapati on 11/01/24.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // earth_-_4788 (540p).mp4
        navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4){
            let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
                }
        play()
        
    }
    
func play()
{
    if let videoURL = Bundle.main.url(forResource: "ep", withExtension: "mp4") {
                let player = AVPlayer(url: videoURL)
                
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = videoView.bounds
                playerLayer.videoGravity = .resizeAspectFill  // You can change the videoGravity according to your needs

                videoView.layer.addSublayer(playerLayer)
                
                // Start playing the video
                player.play()
            }
}

}

