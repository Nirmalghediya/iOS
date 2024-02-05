//
//  ViewController.swift
//  Design
//
//  Created by Nirmal Prajapati on 13/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HomeTable: UITableView!
    let coll = SuperSaveCell()
    let per = Datas().Persentages
    let pric = Datas().price
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DefineCell()
        
       
    }

    func DefineCell()
    {
        HomeTable.delegate = self
        HomeTable.dataSource = self
        
        let DeleteCell = UINib(nibName: "DeleteCell", bundle: nil)
        HomeTable.register(DeleteCell, forCellReuseIdentifier: "DeleteCell")
        
        let SuperCell = UINib(nibName: "SuperSaveCell", bundle: nil)
        HomeTable.register(SuperCell, forCellReuseIdentifier: "SuperSaveCell")
        
        let price = UINib(nibName: "PriceCell", bundle: nil)
        HomeTable.register(price, forCellReuseIdentifier: "PriceCell")
        
    }
    
   



   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + per.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = HomeTable.dequeueReusableCell(withIdentifier: "DeleteCell", for: indexPath) as! DeleteCell
            cell.NotifiedView.RoundCorner(view: cell.NotifiedView, Redius: 10)
            return cell
        } else if indexPath.section == 1 {
            let cell = HomeTable.dequeueReusableCell(withIdentifier: "SuperSaveCell", for: indexPath) as! SuperSaveCell
            return cell
        } else {
            let cell = HomeTable.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceCell
            let priceIndex = indexPath.section - 2 // Adjusting the index for the 'per' array
            if let prices = Int(per[priceIndex]), prices < Int(1.0) {
                cell.lblPersentage.text = per[priceIndex]
                cell.lblPersentage.textColor = UIColor.red
                
            } else {
                cell.lblPersentage.text = per[priceIndex]
                cell.lblPersentage.textColor = UIColor.blue
                
            }
            
            return cell
        }
    }
}
