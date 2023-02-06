//
//  HomeVM.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation
import UIKit
import CoreData

protocol HomeVMDelegate: AnyObject{
    func bringDataOnSuccess()
    func bringDataOnError()
    func deleteDataOnSuccess(at index: Int)
    func deleteDataOnError()
    
}

class HomeVM {
    weak var delegate: HomeVMDelegate?
    var spends = [SpendModel]()
    
    func viewDidLoad(){
        if let spends = CoreDataManager.shared.getData() {
            self.spends = spends
            delegate?.bringDataOnSuccess()
        }
    }

    func deleteData(from data: [SpendModel], at index: Int) {
        if CoreDataManager.shared.deleteSpend(from: data, at: index) {
            delegate?.deleteDataOnSuccess(at: index)
        } else {
            delegate?.deleteDataOnError()
        }
    }
}
