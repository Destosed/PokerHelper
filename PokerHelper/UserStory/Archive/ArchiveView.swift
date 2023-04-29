//
//  ArchiveView.swift
//  PokerHelper
//
//  Created by Nikita Luzhbin on 27.08.2022.
//

import Foundation
import UIKit
import PureLayout
import Lottie

final class ArchiveView: UIViewController {
    
    // MARK: - Instance Properties
    
    private lazy var emptyView = LottieAnimationView()

    private let tableView = UITableView()

    // MARK: -

    private let gameManager: GameManager = DefaultGameManager()
    private var games: [Game] = []
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInisialState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        gameManager.getGames { games in
            DispatchQueue.main.async {
                self.games = games

                self.setEmptyAnimation(isOn: games.isEmpty)

                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Instance Methods
    
    private func setupInisialState() {
        title = "Архив"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(GameArchiveCell.self, forCellReuseIdentifier: GameArchiveCell.reuseIdentifier)

        view.addSubview(tableView)

        tableView.autoPinEdgesToSuperviewSafeArea()
    }

    private func setEmptyAnimation(isOn: Bool) {
        if isOn {
            let mainLabel = UILabel()
            mainLabel.text = "Сохраненных игр нет"
            mainLabel.numberOfLines = 0
            mainLabel.font = .systemFont(ofSize: 20, weight: .bold)
            mainLabel.textAlignment = .center

            emptyView.animation = .named("emptyBox")
            emptyView.loopMode = .loop
            emptyView.play()

            let subLabel = UILabel()
            subLabel.text = "Сыграйте игру и проверьте снова"
            subLabel.font = .systemFont(ofSize: 20, weight: .medium)

            view.addSubview(emptyView)
            emptyView.addSubview(mainLabel)
            emptyView.addSubview(subLabel)

            emptyView.autoPinEdgesToSuperviewSafeArea()

            mainLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 60)
            mainLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
            mainLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
            mainLabel.autoAlignAxis(toSuperviewAxis: .vertical)

            subLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 45)
            subLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        } else {
            emptyView.removeFromSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension ArchiveView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ArchiveDetailView(game: games[indexPath.row])

        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ArchiveView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameArchiveCell.reuseIdentifier) as! GameArchiveCell

        cell.configure(with: games[indexPath.row])

        return cell
    }
    
}
