//
//  CreateVM.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation
import UIKit
import CoreData

protocol CreateVMDelegate: AnyObject {
    func saveOnSuccess()
    func saveOnError()
}

class CreateVM {
    weak var delegate: CreateVMDelegate?
    
    func saveSpend(title: String, money: String, date: String){
        if CoreDataManager.shared.saveSpend(title: title, money: money, date: date) == true {
            delegate?.saveOnSuccess()
        } else {
            delegate?.saveOnError()
        }
    }
}
