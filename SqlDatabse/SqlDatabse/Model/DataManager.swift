//
//  DataManager.swift
//  SqlDatabse
//
//  Created by Nirmal Prajapati on 04/02/24.
//
//SQLite.swift
import Foundation
import SQLite3

class DMLOperation: NSObject
{
    var strpath = ""
    
    
//MARK: DMLSERVICES
    
    func dmlservices(query:String) -> Bool
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        strpath = path + "/DataDEmo.db"
        
        var status = false
        var statement:OpaquePointer? = nil
        
        if sqlite3_open(strpath, &statement)==SQLITE_OK
        {
            if sqlite3_prepare_v2(statement, query, -1, &statement, nil)==SQLITE_OK
            {
                status=true
                sqlite3_step(statement)
            }
            sqlite3_finalize(statement)
            sqlite3_close(statement)
        }
        return status
    }
    

    func fetchuser(query:String) -> Array<Any>
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        strpath = path + "/DataDEmo.db"
        
        var statement:OpaquePointer?=nil
        
        var data = Array<Any>()
        if sqlite3_open(strpath, &statement)==SQLITE_OK
        {
            if sqlite3_prepare_v2(statement, query, -1, &statement, nil)==SQLITE_OK
            {
                while sqlite3_step(statement)==SQLITE_ROW
                {
                    let num = String(cString: sqlite3_column_text(statement, 1))
                    let pas = String(cString: sqlite3_column_text(statement, 2))
                    let age = String(cString: sqlite3_column_text(statement, 3))
                    data.append(num)
                    data.append(pas)
                    data.append(age)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(statement)
        }
        return data
    }
    
    func featchalldata(query:String)->Array<Any>
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        strpath = path + "/DataDEmo.db"
        
        var statement:OpaquePointer? = nil
        
        var data = Array<Any>()
        var dict = Dictionary<String,Any>()
        if sqlite3_open(strpath, &statement)==SQLITE_OK
        {
            if sqlite3_prepare_v2(statement, query, -1, &statement, nil)==SQLITE_OK
            {
                while sqlite3_step(statement)==SQLITE_ROW
                {
                    let fname = String(cString: sqlite3_column_text(statement, 1))
                    let lname = String(cString: sqlite3_column_text(statement, 2))
                    let age = String(cString: sqlite3_column_text(statement, 3))
                    dict["Name"]=fname
                    dict["LastName"]=lname
                    dict["Age"] = age
                    
                    data.append(dict)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(statement)
        }
        return data
    }
        
    
    
}
