//
//  WalletModel.swift
//  WalletApp
//
//  Created by Hakan Adanur on 5.02.2023.
//

import Foundation

struct SpendModel: Codable {
    let amount: String
    let title: String
    let date: String
    let id: UUID

    func getAmount() -> Int? {
        return Int(amount)
    }
}
