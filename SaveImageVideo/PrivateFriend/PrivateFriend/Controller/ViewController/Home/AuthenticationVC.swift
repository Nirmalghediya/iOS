//
//  AuthenticationVC.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//

import UIKit

@available(iOS 13.0, *)
class AuthenticationVC: UIViewController {

    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var btn_submit: UIButton!
    
    @IBOutlet weak var btn_one: UIButton!
    @IBOutlet weak var btn_two: UIButton!
    @IBOutlet weak var btn_three: UIButton!
    
    @IBOutlet weak var btn_Four: UIButton!
    @IBOutlet weak var btn_five: UIButton!
    @IBOutlet weak var btn_six: UIButton!
    
    @IBOutlet weak var btn_seven: UIButton!
    @IBOutlet weak var btn_eight: UIButton!
    @IBOutlet weak var btn_nine: UIButton!
    
    @IBOutlet weak var btn_ten: UIButton!
    @IBOutlet weak var btn_eleven: UIButton!
    @IBOutlet weak var btn_twelve: UIButton!
    
    
    var txtPassword = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: Con.UDFs.password) != nil {
            print("Not Null")
            lbl_Title.text = "Enter Your Password."
            btn_submit.setTitle("SUBMIT", for: .normal)
        } else {
            print("Null")
            lbl_Title.text = "Create your One Time Password"
            btn_submit.setTitle("Create", for: .normal)
        }
        
        btn_submit.Button4X4(btn: btn_submit, Redius: 20)
        btn_one.Circle(btn: btn_one)
        btn_two.Circle(btn: btn_two)
        btn_three.Circle(btn: btn_three)
        btn_Four.Circle(btn: btn_Four)
        btn_five.Circle(btn: btn_five)
        btn_six.Circle(btn: btn_six)
        btn_seven.Circle(btn: btn_seven)
        btn_eight.Circle(btn: btn_eight)
        btn_nine.Circle(btn: btn_nine)
        btn_ten.Circle(btn: btn_ten)
        btn_eleven.Circle(btn: btn_eleven)
        btn_twelve.Circle(btn: btn_twelve)
        
    }
    
    
    @IBAction func btn_digit(_ sender: UIButton) 
    {
        if sender.tag == 201 {//1
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 202 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 203 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 204 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 205 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 206 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 207 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 208 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 209 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 210 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 211 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
        else if sender.tag == 212 {
            txtPassword = txtPassword + (sender.titleLabel?.text)!
        }
    }
    
    
    @IBAction func btn_submit(_ sender: Any) 
    {
        print("password:", txtPassword)
        if txtPassword.count != 0 {
            guard let pass = UserDefaults.standard.object(forKey: Con.UDFs.password) as? String else {
                print("Password not coming")
                UserDefaults.standard.set(txtPassword, forKey: Con.UDFs.password)
                return
            }
            print("pass:",pass)
            if txtPassword == pass{
                print("Open:")
                let vc = storyboard?.instantiateViewController(withIdentifier: "DataVC") as! DataVC
                navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                print("Close:")
                let alert = UIAlertController(title: "Wrong Password!", message: "Wrong Password, Please Try Again.😊", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                txtPassword = ""
            }
        }
    }
    
    

}
