//
//  Constant.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 10/02/24.
//

import Foundation
import UIKit


var Home = ""

struct TokenKey {
    
    static let Login = "Login"
}

class Tokenservice {
    
    static let Tokenintence = Tokenservice()
    let Userdefult = UserDefaults.standard
    
    
    func saveToken(Token:String) {
        Userdefult.set(Token, forKey: TokenKey.Login)
        
    }
     
    func getToken() -> String {
        
        if let token = Userdefult.object(forKey: TokenKey.Login) as? String {
            return token
        } else {
            return ""
        }
        
    }
    
    func checkorLogin() -> Bool {
        if getToken() == "" {
            return true
        } else {
            return false
        }
    }
    
    func removetoken() {
        Userdefult.removeObject(forKey: TokenKey.Login)
    }
      
    
}
