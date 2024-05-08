//
//  ViewAllVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 18/04/24.
//

import UIKit

class ViewAllVC: UIViewController {

    
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    var movies : [MovieElement]?
    var resource = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        
        MovieCollectionView.register(UINib(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        
        MovieCollectionView.delegate = self
        MovieCollectionView.dataSource = self
        
        if let path = Bundle.main.path(forResource: resource, ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),options: .mappedIfSafe)
                let decoder = JSONDecoder()
                self.movies = try decoder.decode([MovieElement].self, from: data)
            }
            catch
            {
                print("Error parsing JSON: \(error)")
            }
        }
        
        
        
        MovieCollectionView.reloadData()
        
    }
    
    @IBAction func btn_Back(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension ViewAllVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MovieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        cell.Movie_Image.View4x4(img: cell.Movie_Image, Redius: 20)
        let movie = movies![indexPath.item]
        cell.lbl_Movie.text = movie.title
        if let thumbnailURLString = movie.thumbnail, let thumbnailURL = URL(string: thumbnailURLString){
            DispatchQueue.global().async {
                            if let imageData = try? Data(contentsOf: thumbnailURL) {
                                DispatchQueue.main.async {
                                    cell.Movie_Image.image = UIImage(data: imageData)
                                }
                            }
                        }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextvc = DetailVC.instantiateViewController() as? DetailVC
        nextvc?.movie = self.movies?[indexPath.row]
        self.navigationController?.pushViewController(nextvc!, animated: true)
        
    }
   /*
    let movie = movies![indexPath.item]
    
    let selectedCell = collectionView.cellForItem(at: indexPath) as! MovieCVCell
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
    
    vc.Images = selectedCell.Movie_Image.image!
    vc.Title = movie.title!
    if let cast = movie.cast
    {
        let castString = cast.joined(separator: ", ")
        vc.cast = "\(castString)"
    }
    else
    {
        vc.cast = "N/A"
    }
    
    if let genres = movie.genres {
        let genresString = genres.map { $0.rawValue }.joined(separator: ", ")
        vc.genres = genresString
    }
    else
    {
        vc.genres = "N/A"
    }
    
    vc.extract = movie.extract!
    vc.year = movie.year!
    
    navigationController?.pushViewController(vc, animated: true)

    */
     
    
    
}

extension ViewAllVC: UICollectionViewDelegateFlowLayout
 {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 3.2
        return CGSize(width: size, height: size * 1.2)
       
    }

 }
