//
//  CreateVC.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import UIKit

class CreateVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: CreateVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createCell = UINib(nibName: "CreateCell", bundle: nil)
        tableView.register(createCell, forCellReuseIdentifier: "createCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Create Spend Table"
    }

}

extension CreateVC {
    static func create() -> CreateVC {
        let vc = CreateVC(nibName: "CreateVC", bundle: nil)
        vc.viewModel = CreateVM()
        return vc
    }
}

extension CreateVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createCell") as! CreateCell
        cell.configure()
        cell.delegate = self
        return cell
    }
}

extension CreateVC: CreateCellDelegate {
    func saveButtonTapped(title: String, money: String, date: String) {
        viewModel.saveSpend(title: title, money: money, date: date)
        navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func error() {
        showAlert(title: "Error", message: "Try Again")
    }
}

extension CreateVC: CreateVMDelegate {
    func saveOnSuccess() {
        self.tableView.reloadData()
    }
    
    func saveOnError() {
        showAlert(title: "Error", message: "Try Again")
    }
    
    
}
