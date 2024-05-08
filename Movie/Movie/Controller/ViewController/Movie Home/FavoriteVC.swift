//
//  FavoriteVC.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 17/04/24.
//

import UIKit

class FavoriteVC: UIViewController {

    
    @IBOutlet weak var viewFavoriteTable: UITableView!
    
    @IBOutlet weak var txt_Search: UITextField!
    
    var genres : Genres?
    var filterGenres : Genres? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        viewFavoriteTable.register(UINib(nibName: "GenerTVCell", bundle: nil), forCellReuseIdentifier: "GenerTVCell")
        
        viewFavoriteTable.delegate = self
        viewFavoriteTable.dataSource = self
        
        self.genres = getGenres()
        filterGenres = genres
        
        let placeholder = "Search"
        let placeholdercolor = UIColor.black.withAlphaComponent(CGFloat(10))
        
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeholdercolor])
        
        txt_Search.attributedPlaceholder = attributedPlaceholder
        txt_Search.placeholder = placeholder
        txt_Search.borderStyle = .none
        txt_Search.layer.cornerRadius = 10
      //  txt_Search.layer.borderWidth = 1
        //txt_Search.layer.borderColor = UIColor.blue.cgColor
        txt_Search.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

   

}
extension FavoriteVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterGenres?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = viewFavoriteTable.dequeueReusableCell(withIdentifier: "GenerTVCell", for: indexPath) as! GenerTVCell
        cell.lbl_gener.text = filterGenres?[indexPath.row]
        cell.BG.View4x4(view: cell.BG, Redius: 20)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = getMoviesGenres(forGenre: filterGenres![indexPath.row])
        let nextVC = ViewAllVC.instantiateViewController() as? ViewAllVC
        nextVC?.movies = data
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
}

extension FavoriteVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        // Perform search based on the searchText
        print("Search text: \(searchText)")
        
        
        if searchText.isEmpty {
            self.filterGenres = genres
        }
        else {
            self.filterGenres = genres?.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        DispatchQueue.main.async {
            self.viewFavoriteTable.reloadData()
        }
        return true
    }
}
