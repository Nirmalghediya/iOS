//
//  CategoriesVC.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

class CategoriesVC: UIViewController {

    
    @IBOutlet weak var CategoriesTable: UITableView!
    
    let ImagesData = FeatureData().CImage
    let TextData = FeatureData().CText
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesTable.delegate = self
        CategoriesTable.dataSource = self
        CategoriesTable.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellReuseIdentifier: "CategoriesCell")
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

}
extension CategoriesVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoriesTable.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.lbl_Text.text = TextData[indexPath.row]
        cell.Images.image = UIImage(named: ImagesData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WallpaperVC") as! WallpaperVC
        vc.texts = TextData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
