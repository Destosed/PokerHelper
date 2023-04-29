//
//  StartGameView.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 24.12.2022.
//

import UIKit
import PureLayout

final class StartGameView: UIViewController {
    
    // MARK: - Nested Types
    
    enum GameStatus: String {
        
        // MARK: - Enumeration cases
        
        case unstarted
        case inProgress
        
        // MARK: - Instance Methods
        
        func toText() -> String {
            switch self {
            case .unstarted:
                return "Не начата"
                
            case .inProgress:
                return "В процессе"
            }
        }
    }
    
    // MARK: - Instance Properties

    let gameManager: GameManager = DefaultGameManager()
    
    var navActionButton = UIBarButtonItem()
    let statusLabel = UILabel()
    let tableView = SelfSizedTableView()
    let actionButton = UIButton()
    
    // MARK: -
    
    var gameStatus: GameStatus = .unstarted {
        didSet {
            statusLabel.text = "Статус: \(gameStatus.toText())"
            
            navigationItem.rightBarButtonItem = gameStatus == .unstarted ? navActionButton : nil
            
            actionButton.setTitle(gameStatus == .unstarted ? "Начать" : "Закончить",
                                  for: .normal)
            
            tableView.reloadData()
        }
    }
    
    var game = Game()
    var players: [Player] = []
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.reuseIdentifier)
        
        setupInitialState()
    }
    
    // MARK: - Instance Methods
    
    private func setupInitialState() {
        navActionButton = UIBarButtonItem(image: .init(systemName: "plus"),
                                          style: .done,
                                          target: self,
                                          action: #selector(didTapAddPlayer))
        navigationItem.rightBarButtonItem = navActionButton
        
        title = "Кэш-игра"
        view.backgroundColor = .white
        
        statusLabel.text = "Статус: \(gameStatus.toText())"
        statusLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        
        actionButton.setTitle("Начать", for: .normal)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        actionButton.configuration?.contentInsets = .init(top: 3, leading: 5, bottom: 3, trailing: 5)
        actionButton.backgroundColor = .black
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 45 / 2
        actionButton.clipsToBounds = true
        
        view.addSubview(statusLabel)
        view.addSubview(tableView)
        view.addSubview(actionButton)
        
        statusLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        statusLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15)
        
        tableView.autoPinEdge(.top, to: .bottom, of: statusLabel, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        
        actionButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 25)
        actionButton.autoSetDimensions(to: .init(width: 100, height: 45))
        actionButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddPlayer() {
        showAlert(title: "Добавить игрока",
                  textFields: [
                    .init(placeholder: "Имя", type: .default, isAutocapitalizationEnabled: true),
                    .init(placeholder: "Начальный стек", type: .numberPad)
                  ],
                  isCancellable: true) { strings in
            if let amount = Int(strings[1]) {
                let name = strings[0]
                
                self.players.append(.init(name: name, amount: amount))
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func didTapActionButton() {
        switch gameStatus {
        case .unstarted:
            if players.count < 2 {
                showAlert(title: "Стоп",
                          message: "Минимальное количество игроков: 2",
                          actions: [.init(title: "Ок")])
            } else if players.count > 8 {
                showAlert(title: "Стоп",
                          message: "Максимальное количество игроков: 8",
                          actions: [.init(title: "Ок")])
            } else {
                game.startDate = Date()
                game.players = players
                gameStatus = .inProgress
            }
            
        case .inProgress:
            if !players.filter({ $0.endAmount == nil }).isEmpty {
                showAlert(title: "Упс...",
                          message: "Не все игроки заполнили финальный стек",
                          actions: [.init(title: "Ok")])
            } else {
                let startSumm = players.map { $0.amount }.reduce(0, +)
                let endSumm = players.map { $0.endAmount ?? 0 }.reduce(0, +)
                
                if startSumm != endSumm {
                    showAlert(title: "Упс...",
                              message: "В начале было: \(startSumm), \nа в конце: \(endSumm)",
                              actions: [
                                .init(title: "Исправлю"),
                                .init(title: "Похуй", action: {
                                    self.game.endDate = Date()
                                    
                                    self.gameManager.save(game: self.game)

                                    self.navigationController?.popViewController(animated: true)
                                })
                              ])
                } else {
                    game.endDate = Date()
                    
                    gameManager.save(game: game)
                    
                    showAlert(title: "Игра сохранена",
                              message: "Чекни как будет время во вкладке Архив",
                              actions: [.init(title: "Ок", action: {
                        self.navigationController?.popViewController(animated: true)
                    })])
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension StartGameView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let player = players[indexPath.row]

        switch gameStatus {
        case .unstarted:
            showAlert(title: "Редактирование игрока",
                      textFields: [.init(placeholder: player.name, type: .default, isAutocapitalizationEnabled: true),
                                   .init(placeholder: String(player.amount), type: .numberPad)],
                      isCancellable: true) { strings in
                if let amount = Int(strings[1]) {
                    let name = strings[0]

                    player.name = name
                    player.amount = amount

                    self.tableView.reloadData()
                }
            }

        case .inProgress:
            showAlert(title: "Финальный стек игрока: \(player.name)",
                      message: nil,
                      textFields: [.init(placeholder: "Финальный стек", type: .numberPad)],
                      isCancellable: true) { strings in
                if let amount = Int(strings[0]) {
                    player.endAmount = amount
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension StartGameView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Игроки"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.reuseIdentifier) as! PlayerCell

        cell.configure(for: players[indexPath.row], isGameStarted: gameStatus != .unstarted)

        return cell
    }
}
