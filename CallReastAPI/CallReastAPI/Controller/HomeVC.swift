//
//  HomeVC.swift
//  CallReastAPI
//
//  Created by Nirmal Prajapati on 11/01/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class HomeVC: UIViewController {

    
    @IBOutlet weak var CountryTable: UITableView!
    
    var apiArray = [APIModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let countrynib = UINib(nibName: "CountryCell", bundle: nil)
        CountryTable.register(countrynib, forCellReuseIdentifier: "CountryCell")
        apicalling()
    }
    
    func apicalling()
      {

          let url = URL(string: "https://restcountries.com/v3.1/all")

          URLSession.shared.dataTask(with: url!) { (data, response, error) in
              do
              {
                  let json = try JSON(data: data!)
                  let finaldata = json.arrayObject?.count

                  for i in 0..<finaldata!
                  {
                      let name = json[i]["name"]["common"].stringValue
                      let cap = json[i]["capital"][0].stringValue
                      let lat = json[i]["latlng"][0].doubleValue
                      let lng = json[i]["latlng"][1].doubleValue
                      let flag = json[i]["flags"]["png"].stringValue
                      let map = json[i]["maps"]["googleMaps"].stringValue
                      let pop = json[i]["population"].intValue

                      self.apiArray.append(APIModel(name: name, flags: flag, maps: map, lat: lat, lng: lng, population: pop, capital: cap))
                  }

                  print(self.apiArray)
                  DispatchQueue.main.async {
                      self.CountryTable.reloadData()
                  }

              }
              catch
              {
                  print(error.localizedDescription)
              }
          }.resume()

      }

  }
    



extension HomeVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = CountryTable.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
//        cell.lbl_country.text = apiArray[indexPath.row].name
//                cell.lbl_cpital.text = apiArray[indexPath.row].capital
//                cell.lbl_population.text = String((apiArray[indexPath.row]).population!)
//                cell.flag_img.kf.setImage(with: URL(string: apiArray[indexPath.row].flags!))
//
        cell.countryImage.layer.cornerRadius = 20
        cell.countryImage.kf.setImage(with: URL(string: apiArray[indexPath.row].flags!))
        cell.lblCapital.text = apiArray[indexPath.row].capital
        cell.lblCountry.text = apiArray[indexPath.row].name
        cell.lblPopulation.text = String((apiArray[indexPath.row]).population!)
        return cell
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let mapvc = (storyboard?.instantiateViewController(identifier: "mapvc")) as! MapViewController
//       
//        mapvc.latval = apiArray[indexPath.row].lat!
//        mapvc.longval = apiArray[indexPath.row].lng!
//        navigationController?.pushViewController(mapvc, animated: true)
//    
//    }
    
}
