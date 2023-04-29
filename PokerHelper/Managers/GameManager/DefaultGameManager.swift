//
//  DefaultGameManager.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 25.12.2022.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol GameManager {
    func save(game: Game)
    func removeGame(with id: String)

    func getGames(completion: @escaping (([Game]) -> Void))
}

final class DefaultGameManager: GameManager {

    // MARK: - Nested Types

    private enum Constants {

        static let gamesKey = "Games"
    }

    // MARK: - Instance Properties

    private let storage = Firestore.firestore()

    private var deviceHeader: String {
        UIDevice.current.name + "_" + (UIDevice.current.identifierForVendor?.uuidString ?? "Unknown")
    }

    // MARK: - Instance Methods

    func save(game: Game) {
        try? storage.collection(deviceHeader)
            .addDocument(from: game)
    }

    func removeGame(with id: String) {
        storage.collection(deviceHeader)
            .document(id)
            .delete()
    }

    func getGames(completion: @escaping (([Game]) -> Void)) {
        storage.collection(deviceHeader).getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else {
                let games = querySnapshot!.documents.compactMap { try? $0.data(as: Game.self) }

                completion(games)
            }
        }
    }
}
