//
//  DataVC.swift
//  DictionaryTypeAPI
//
//  Created by Nirmal Prajapati on 01/03/24.
//

import UIKit

class DataVC: UIViewController {

    @IBOutlet weak var DataTableview: UITableView!
    
    
    
    var apidataa=[APIModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apicalling()
        DataTableview.delegate = self
        DataTableview.dataSource = self
    }
    func apicalling()
    {
        let url=URL(string: "https://data.covid19india.org/data.json")
        
        URLSession.shared.dataTask(with: url!) {data, response, error in
            
            do
            {
                let result = try JSONDecoder().decode(NewData.self, from: data!)
                self.apidataa = result.statewise!
                print(self.apidataa)
                
                DispatchQueue.main.async {
                    self.DataTableview.reloadData()
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }

}

extension DataVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apidataa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataTableview.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.lbl_state.text = apidataa[indexPath.row].state
        cell.lbl_statecode.text = apidataa[indexPath.row].statecode
        cell.lbl_Death.text = apidataa[indexPath.row].deaths
        return cell
    }
    
    
}
