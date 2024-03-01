//
//  SearchVC.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class SearchVC: UIViewController {

    
    
    @IBOutlet weak var txt_search: UITextField!
    
    @IBOutlet weak var ImageCollection: UICollectionView!
    
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
    var texts:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        ImageCollection.dataSource = self
        ImageCollection.delegate = self
        
        ImageCollection.register(UINib(nibName: "ThiredCell", bundle: nil), forCellWithReuseIdentifier: "ThiredCell")
        
        //MARK: Fetch WallPaper
        FetchImage(query: texts)
        
        txt_search.layer.cornerRadius = 20
        FetchImage(query: "Wallpaper")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Fetch Images
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
                    self?.ImageCollection.reloadData()
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
    
    @IBAction func btn_Search(_ sender: Any)
    {
        let Search = txt_search.text
        FetchImage(query: Search!)
    }
    
    
  

}


//MARK: CollectionView
extension SearchVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imagestring = results[indexPath.row].urls.full
        let cell = ImageCollection.dequeueReusableCell(withReuseIdentifier: "ThiredCell", for: indexPath) as! ThiredCell
        cell.configure(with: imagestring!)
        cell.Back_View.View4x4(view: cell.Back_View, Redius: 18)
        cell.Images.layer.cornerRadius = 18
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! ThiredCell
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
        vc.Image = selectedCell.Images.image!
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: CollectionViewDelegateFlowLayout
extension SearchVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
          let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
          let size:CGFloat = (collectionView.frame.size.width - space) / 3.4
        return CGSize(width: size, height: size * 1.3)
      }

}
