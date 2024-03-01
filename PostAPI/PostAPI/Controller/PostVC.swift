//
//  PostVC.swift
//  PostAPI
//
//  Created by Nirmal Prajapati on 14/02/24.
//

import UIKit

class PostVC: UIViewController {

    
    @IBOutlet weak var txt_Userid: UITextField!
    
    @IBOutlet weak var txt_Title: UITextField!
    
    @IBOutlet weak var txt_Body: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btn_Post(_ sender: Any)
    {
        setupPostMethod()
    }
    
    func setupPostMethod()
    {
        guard let uid = self.txt_Userid.text else { return }
        guard let title = self.txt_Title.text else { return }
        guard let body = self.txt_Body.text else { return }
        
        if let url = URL(string:"https://jsonplaceholder.typicode.com/posts"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters:[String : Any] = [
                "useId":uid,
                "title":title,
                "body":body
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200...299) ~= response.statusCode else
                    {
                        print("Status Code: \(response.statusCode)")
                        print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data,options: [])
                    print(json)
                    print(data)
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    

}

extension Dictionary
{
    func percentEscaped() -> String
    {
        return map { (key, Value) in
            let escapedkey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(Value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedkey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet
{
    static let urlQueryValueAllowed: CharacterSet = {
       let generalDelimitersToEncode = ":#[]@"
        let subDelimilersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimilersToEncode)")
        return allowed
    }()
}
