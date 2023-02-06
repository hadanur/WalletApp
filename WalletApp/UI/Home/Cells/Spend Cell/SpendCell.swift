//
//  SpendCell.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation
import UIKit

class SpendCell: UITableViewCell {
    @IBOutlet private weak var spendTitle: UILabel!
    @IBOutlet private weak var spendDate: UILabel!
    @IBOutlet private weak var spendCost: UILabel!
    @IBOutlet private weak var spendView: UIView!
    
    func configure(spend: SpendModel) {
        spendTitle.text = spend.title
        spendCost.text = "\(spend.amount) ₺"
        spendDate.text = spend.date
    }
}
