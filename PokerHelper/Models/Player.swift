//
//  Player.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 25.12.2022.
//

import Foundation

final class Player: Codable {

    // MARK: - Instance Properties

    var name: String
    var amount: Int
    var endAmount: Int?

    // MARK: - Initialization

    init(name: String, amount: Int, endAmount: Int? = nil) {
        self.name = name
        self.amount = amount
        self.endAmount = endAmount
    }
}
