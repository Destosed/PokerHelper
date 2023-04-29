//
//  Game.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 25.12.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Game: Codable {

    // MARK: - Instance Properties

    @DocumentID var id: String?

    var startDate: Date?
    var endDate: Date?
    var players: [Player] = []
}
