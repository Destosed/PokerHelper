//
//  ArchiveDetailView.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 03.01.2023.
//

import UIKit

final class ArchiveDetailView: UIViewController {

    // MARK: - Properties

    private let gameManager: GameManager = DefaultGameManager()
    private let tableView = SelfSizedTableView()

    private let game: Game

    // MARK: - Init

    init(game: Game) {
        self.game = game

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboards are painfull")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.reuseIdentifier)
        
        setupInitialState()
    }

    // MARK: - Instance Methods

    private func setupInitialState() {
        title = "Кэш-игра"

        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "trash"),
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(deleteGame))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewSafeArea(with: .init(top: 20, left: 20, bottom: 0, right: 20),
                                                  excludingEdge: .bottom)
    }

    // MARK: -

    @objc private func deleteGame() {
        showAlert(title: "Вы уверены?",
                  message: nil,
                  isCancellable: true,
                  actions: [.init(title: "Да",
                                  action: {
            self.gameManager.removeGame(with: self.game.id ?? "")
            self.navigationController?.popViewController(animated: true)
        })])
    }
}

// MARK: - UITableViewDataSource

extension ArchiveDetailView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Игроки"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.reuseIdentifier) as! PlayerCell

        cell.configure(for: game.players[indexPath.row], isGameStarted: true)

        return cell
    }
}
