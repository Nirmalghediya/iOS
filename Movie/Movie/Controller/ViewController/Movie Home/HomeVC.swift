//
//  HomeVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 17/04/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var SliderCollectionView: UICollectionView!
    
    @IBOutlet weak var oldCollectionView: UICollectionView!
    
    @IBOutlet weak var MiniCollectionView: UICollectionView!
    
    @IBOutlet weak var NewCollectionView: UICollectionView!
    
    @IBOutlet weak var PageOne: UIPageControl!
    
    @IBOutlet weak var PageTwo: UIPageControl!
    
    
    //MARK: Property
    let pages = ["1","2","3","4","5","6"]
    var timer = Timer()
    var counter = 0
    let pagess = ["7","8","9"]
    var movies : [MovieElement] = []
    var getMovieOf : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        
        //MARK: Register NIB
        
        SliderCollectionView.register(UINib(nibName: "SliderCVCell", bundle: nil), forCellWithReuseIdentifier: "SliderCVCell")
        
        MiniCollectionView.register(UINib(nibName: "MiniSliderCVCell", bundle: nil), forCellWithReuseIdentifier: "MiniSliderCVCell")
        
        oldCollectionView.register(UINib(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        
        NewCollectionView.register(UINib(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        
        //MARK: Define Collectionview delegate & Datasources
        SliderCollectionView.delegate = self
        SliderCollectionView.dataSource = self
        
        MiniCollectionView.delegate = self
        MiniCollectionView.dataSource = self
        
        oldCollectionView.delegate = self
        oldCollectionView.dataSource = self
        
        NewCollectionView.delegate = self
        NewCollectionView.dataSource = self
        
        //PageView
        PageOne.numberOfPages = pages.count
        PageOne.currentPage = 0
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
        
        PageTwo.numberOfPages = pagess.count
        PageTwo.currentPage = 0
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImages), userInfo: nil, repeats: true)
           }
      
       NinetysMovie()
        NewMovie()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }

    //MARK: - SlideImage
    @objc func changeImages() {
        if counter < pagess.count {
             let index = IndexPath.init(item: counter, section: 0)
             self.MiniCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            PageTwo.currentPage = counter
             counter += 1
        } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.MiniCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            PageTwo.currentPage = counter
              counter = 1
          }
      }
    
    @objc func changeImage() {
             
         if counter < pages.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.SliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             PageOne.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.SliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             PageOne.currentPage = counter
               counter = 1
           }
      }

    
    
    func NinetysMovie()
    {
        if let path = Bundle.main.path(forResource: "movies-2020s", ofType: "json"){
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
        oldCollectionView.reloadData()
    }
    
    func NewMovie()
    {
        if let path = Bundle.main.path(forResource: "movies-2010s", ofType: "json"){
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
        NewCollectionView.reloadData()
    }
    
    
    @IBAction func btn_old(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewAllVC") as! ViewAllVC
        vc.resource = "movies-2020s"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_new(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewAllVC") as! ViewAllVC
        vc.resource = "movies-2010s"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == SliderCollectionView{
            return pages.count
        }
        else if collectionView == MiniCollectionView
        {
            return pagess.count
        }
        else if collectionView == oldCollectionView
        {
            return 9
        }
        else
        {
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SliderCollectionView
        {
            let cell = SliderCollectionView.dequeueReusableCell(withReuseIdentifier: "SliderCVCell", for: indexPath) as! SliderCVCell
            cell.SliderImage.image = UIImage(named: pages[indexPath.row])
            cell.SliderImage.View4x4(img: cell.SliderImage, Redius: 20)
            return cell
        }
        else if collectionView == MiniCollectionView
        {
            let cell = MiniCollectionView.dequeueReusableCell(withReuseIdentifier: "MiniSliderCVCell", for: indexPath) as! MiniSliderCVCell
            cell.Movie_Image.image = UIImage(named: pagess[indexPath.row])
            cell.Movie_Image.View4x4(img: cell.Movie_Image, Redius: 20)
            return cell
        }
        else if collectionView == oldCollectionView
        {
            let cell = oldCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
            cell.Movie_Image.View4x4(img: cell.Movie_Image, Redius: 20)
            let movie = movies[indexPath.item]
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
        else
        {
            let cell = NewCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
            cell.Movie_Image.View4x4(img: cell.Movie_Image, Redius: 20)
            let movie = movies[indexPath.item]
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == oldCollectionView
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ViewAllVC") as! ViewAllVC
            vc.resource = "movies-2020s"
            navigationController?.pushViewController(vc, animated: true)
        }
        if collectionView == NewCollectionView
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ViewAllVC") as! ViewAllVC
            vc.resource = "movies-2010s"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == SliderCollectionView
        {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height

            return CGSize(width: width, height: height)

        }
        else if collectionView == MiniCollectionView
        {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height

            return CGSize(width: width, height: height)
        }
        else if collectionView == oldCollectionView
        {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 3.2
        return CGSize(width: size, height: size * 1.2)
        }
        else
        {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 3.2
        return CGSize(width: size, height: size * 1.2)
        }
       
    }
}
