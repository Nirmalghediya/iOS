//
//  WatchListVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 17/04/24.
//

import UIKit

class WatchListVC: UIViewController{
    

    @IBOutlet weak var WatchlistTableView: UITableView!
    var movies : [MovieElement]?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.movies = readMovieElements()
        
        //WatchListTVCell
        WatchlistTableView.register(UINib(nibName: "WatchListTVCell", bundle: nil), forCellReuseIdentifier: "WatchListTVCell")
        WatchlistTableView.delegate = self
        WatchlistTableView.dataSource = self
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
   

   

}

extension WatchListVC: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WatchlistTableView.dequeueReusableCell(withIdentifier: "WatchListTVCell", for: indexPath) as! WatchListTVCell
        cell.Movie_Image.kf.setImage(with: URL(string: movies?[indexPath.row].thumbnail ?? ""),placeholder: UIImage(named: "placeholder"))
        cell.lbl_extract.text = movies?[indexPath.row].cast?.isEmpty ?? false ? "No Cast Deatils" : movies?[indexPath.row].cast?[0]
        cell.lbl_Title.text = movies?[indexPath.row].title
        cell.lbl_Year.text = "\(movies?[indexPath.row].year! ?? 0)"
        cell.selectionStyle = .none
        cell.BG.View4x4(view: cell.BG, Redius: 20)
        cell.Movie_Image.View4x4(img: cell.Movie_Image, Redius: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextvc = DetailVC.instantiateViewController() as? DetailVC
        nextvc?.movie = self.movies?[indexPath.row]
        self.navigationController?.pushViewController(nextvc!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.movies = readMovieElements()
        DispatchQueue.main.async {
            self.WatchlistTableView.reloadData()
        }
        if movies?.count == 0 || movies == nil {
            self.WatchlistTableView.isHidden = true
        }
        else{
            self.WatchlistTableView.isHidden = false
        }
    }
    
}
