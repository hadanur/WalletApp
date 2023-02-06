//
//  HomeCell.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation
import UIKit

class TotalCostCell: UITableViewCell {
    @IBOutlet private weak var cashView: UIView!
    @IBOutlet private weak var costLabel: UILabel!
    @IBOutlet private weak var favouritiesView: UIView!
    
    func configure(data: SpendModel) {
        setupUI()
        
        guard let amount = data.getAmount() else { return }
        costLabel.text = "\(amount) ₺"
        
        print("TEST --> Amount Int: \(amount)")
    // costLabel.text = String(describing: data.amount.sum())
    }
    
    private func setupUI() {
        cashView.layer.cornerRadius = 12
        cashView.layer.borderWidth = 0.15
        cashView.layer.shadowOffset = CGSizeMake(2, 4)
        cashView.layer.shadowColor = UIColor.purple.cgColor
        cashView.layer.shadowOpacity = 1.13
        cashView.layer.shadowRadius = 24
        

    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

