//
//  ViewController.swift
//  SqlDatabse
//
//  Created by Nirmal Prajapati on 04/02/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txt_FirstName: UITextField!
    
    @IBOutlet weak var txt_LastName: UITextField!
    
    @IBOutlet weak var txt_Age: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func btn_Save(_ sender: Any)
    {
        SaveInfo()
    }
    
    @IBAction func btn_Show(_ sender: Any) {
    }
    
    func SaveInfo()
    {
        if txt_FirstName.text=="" || txt_LastName.text=="" || txt_Age.text==""
        {
            let alert = UIAlertController(title: "Error", message: "Please input proper details!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        else
        {
            let newuser_query = "insert into studinfo(Name,LastName,Age)values('\(txt_FirstName.text!)','\(txt_LastName.text!)','\(txt_Age.text!)')"
            print(newuser_query)
            
            let dml = DMLOperation()
            let status = dml.dmlservices(query: newuser_query)
            
            if status==true
            {
                let alert = UIAlertController(title: "Success", message: "Your Data insert SucessFully.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { ACTION in
                    self.txt_FirstName.text = ""
                    self.txt_LastName.text = ""
                    self.txt_Age.text = ""
                }))
                present(alert, animated: true)
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "Something went Wrong.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }
    }
    
}

