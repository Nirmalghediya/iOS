//
//  DatabaseManager.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//

import Foundation
import CoreData
import UIKit

@available(iOS 13.0, *)
class DatabaseManager {
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addRecord(_ record: RecordModel) {
        let recordEntity = RecordEntitie(context: context)
        addUpdateRecord(recordEntity: recordEntity, record: record)
        
    }
    
    
    private func addUpdateRecord(recordEntity: RecordEntitie, record: RecordModel) {
        recordEntity.type = record.type
        recordEntity.name = record.name
        recordEntity.filename = record.filename
        saveContect()
    }
    
    func fetchRecords() -> [RecordEntitie] {
        var records: [RecordEntitie] = []
        
        do {
            records = try context.fetch(RecordEntitie.fetchRequest())
        } catch {
            print("fetche error")
        }
        return records
    }
    
    func saveContect() {
        do{
            try context.save()
        }catch{
            print("not saved")
        }
    }
    
    func deleteRecord(recordEntity: RecordEntitie) {
       // let recordURL = URL.documentsDirectory.appending(component: recordEntity.filename ?? "").appendingPathExtension("m4a")
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let rc = documentURL.appendingPathComponent(recordEntity.filename ?? "").appendingPathExtension("png")
        do {
            try FileManager.default.removeItem(at: rc)
        } catch {
            print("delete file error")
        }
        context.delete(recordEntity)
        saveContect()
    }
    
}



struct RecordModel {
    let type: String
    let name: String
    let filename: String
}
