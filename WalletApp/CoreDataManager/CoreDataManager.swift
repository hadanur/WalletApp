//
//  CoreDataManager.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    func saveSpend(title: String, money: String, date: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBody = NSEntityDescription.insertNewObject(forEntityName: "Spend", into: context)
        
        newBody.setValue(title, forKey: "title")
        newBody.setValue(money, forKey: "money")
        newBody.setValue(UUID(), forKey: "id")
        newBody.setValue(date, forKey: "date")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getData() -> [SpendModel]? {
        var spends = [SpendModel]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Spend")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let title = result.value(forKey: "title") as? String,
                   let id = result.value(forKey: "id") as? UUID,
                   let money = result.value(forKey: "money") as? String,
                   let date = result.value(forKey: "date") as? String {
                    let spend = SpendModel(amount: money, title: title, date: date, id: id)
                    spends.append(spend)
                }
            }
            return spends
        } catch {
            print("error")
            return nil
        }
    }
    
    func deleteSpend(from data: [SpendModel], at index: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Spend")
        
        let idString = data[index].id.uuidString
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        
        if let results = try? context.fetch(fetchRequest) {
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
            
            do {
                try context.save()
            } catch {
                return false
            }
            
            return true
        }
        
        return false
    }
}

