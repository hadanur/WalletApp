//
//  HomeVC.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let totalCostCell = UINib(nibName: "TotalCostCell", bundle: nil)
        tableView.register(totalCostCell, forCellReuseIdentifier: "totalCostCell")
        
        let spendCell = UINib(nibName: "SpendCell", bundle: nil)
        tableView.register(spendCell, forCellReuseIdentifier: "spendCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        
        viewModel.viewDidLoad()
        
      setupUI()
    }
    
    @objc private func addButtonClicked(){
        let createVC = CreateVC.create()
        navigationController?.pushViewController(createVC, animated: true)
     }

}

extension HomeVC {
    static func create() -> HomeVC {
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        vc.viewModel = HomeVM()
        return vc
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        title = "Wallet App"
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.spends.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalCostCell") as! TotalCostCell
            let data = viewModel.spends[indexPath.row]
            cell.configure(data: data)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "spendCell") as! SpendCell
            let data = viewModel.spends[indexPath.row - 1]
            cell.configure(spend: data)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
    
        } else {
            if editingStyle == .delete {
                viewModel.deleteData(from: viewModel.spends, at: indexPath.row)
            }
        }
    }
}

extension HomeVC: HomeVMDelegate {
    func bringDataOnSuccess() {
        self.tableView.reloadData()
    }
    
    func bringDataOnError() {
        showAlert(title: "Error", message: "Tekrar Deneyin")
    }
    
    func deleteDataOnSuccess(at index: Int) {
        viewModel.spends.remove(at: index)
        tableView.reloadData()
    }
    
    func deleteDataOnError() {
        showAlert(title: "Hata", message: "Veri Silinemedi.")

    }
    
    
}
