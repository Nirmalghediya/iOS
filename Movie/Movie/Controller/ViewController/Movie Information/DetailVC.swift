//
//  DetailVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 18/04/24.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var Movie_Image: UIImageView!
    
    @IBOutlet weak var Detail_View: UIView!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var lbl_year: UILabel!
    
    @IBOutlet weak var lbl_cast: UILabel!
    
    @IBOutlet weak var lbl_genres: UILabel!
    
    @IBOutlet weak var lbl_Extract: UILabel!
    
    @IBOutlet weak var Movie: UIImageView!
    
    @IBOutlet weak var addToWatchlistBtn: UIButton!
    
    var Images = UIImage()
    var Title = ""
    var year = 0
    var cast = ""
    var genres = ""
    var extract = ""
    var movie : MovieElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        
        addToWatchlistBtn.Button4X4(btn: addToWatchlistBtn, Redius: 20)
        Movie.View4x4(img: Movie, Redius: 20)
        self.Movie_Image.kf.setImage(with: URL(string: movie?.thumbnail ?? ""),placeholder: UIImage(named: "placeholder"))
        self.Movie.kf.setImage(with: URL(string: movie?.thumbnail ?? ""),placeholder: UIImage(named: "placeholder"))
        self.lbl_title.text = movie?.title ?? "Some Issue"
        self.lbl_year.text = "\(movie?.year! ?? 0)"
        self.lbl_cast.text = movie?.cast?.isEmpty ?? false ? "No Cast Deatils" : movie?.cast?[0]
        self.lbl_Extract.text = movie?.extract ?? "No Description Available"
        
        self.addToWatchlistBtn.setTitle(readMovieElements(byTitle: (movie?.title)!) ?? false ? "Remove From Watchlist" : "Add to Watchlist", for: .normal)
    }
    

    @IBAction func btn_Back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAddTowatchList(_ sender: UIButton)
    {
        readMovieElements(byTitle: (movie?.title)!) ?? false ? removeMovieElement(withTitle: (movie?.title)!) : addMovieElement(self.movie!)
        self.addToWatchlistBtn.setTitle(readMovieElements(byTitle: (movie?.title)!) ?? false ? "Remove From Watchlist" : "Add to Watchlist", for: .normal)
    }
    

    
}
