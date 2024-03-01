//
//  HomeVC.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var FeaturedCollection: UICollectionView!
    
    @IBOutlet weak var WallpaperCollection: UICollectionView!
    
    let Images = FeatureData().FImage
    let Text = FeatureData().text
    
    struct APIResponse:Codable
    {
        let total:Int?
        let total_pages:Int?
        let results: [Result]
    }

    struct Result:Codable
    {
        let id:String?
        let urls: URLS
    }

    struct URLS:Codable
    {
        let full:String?
    }
    
    var results:[Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        FeaturedCollection.delegate = self
        FeaturedCollection.dataSource = self
        
        WallpaperCollection.delegate = self
        WallpaperCollection.dataSource = self
        
        FeaturedCollection.register(UINib(nibName: "FeaturedCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCell")
        
        WallpaperCollection.register(UINib(nibName: "ThiredCell", bundle: nil), forCellWithReuseIdentifier: "ThiredCell")
        
        FetchImage(query: "Car")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func FetchImage(query:String)
    {
        
        let url = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=uPReUKWYhDJKXmMssvWXFRvR0jLrerD1lsYhYE2zqdY"
        
        guard let urls = URL(string: url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: urls) { [weak self] data, _, error in
            guard let data = data,error == nil else {
                return
            }
            do
            {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.WallpaperCollection.reloadData()
                }
                
            }
            catch
            {
                print("Error:",error.localizedDescription)
            }
            print("Got Data")
        }
        task.resume()
    }
}

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == FeaturedCollection
        {
            return Text.count
        }
        else
        {
            return results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == FeaturedCollection
        {
            let cell = FeaturedCollection.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! FeaturedCell
            cell.Back_View.View4x4(view: cell.Back_View, Redius: 18)
            cell.Images.layer.cornerRadius = 18
            cell.Images.image = UIImage(named: Images[indexPath.row])
            cell.lbl_Text.text = Text[indexPath.row]
            return cell
        }
        else
        {
            let cell = WallpaperCollection.dequeueReusableCell(withReuseIdentifier: "ThiredCell", for: indexPath) as! ThiredCell
            let imagestring = results[indexPath.row].urls.full
            cell.configure(with: imagestring!)
            cell.Back_View.View4x4(view: cell.Back_View, Redius: 18)
            cell.Images.layer.cornerRadius = 18
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == FeaturedCollection
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "WallpaperVC") as! WallpaperVC
            vc.texts = Text[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeVC:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                if collectionView == FeaturedCollection
                {
                   
                    let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                    let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                    let size:CGFloat = (collectionView.frame.size.width - space) / 3.4
                  return CGSize(width: size, height: size * 1.3)
                }
        
        else
        {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 3.4
          return CGSize(width: size, height: size * 1.3)
        }
                
        
                     
         }
        
        
        
        
    }

