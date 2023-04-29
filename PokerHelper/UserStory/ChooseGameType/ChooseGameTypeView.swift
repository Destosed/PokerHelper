//
//  ChooseGameTypeView.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 24.12.2022.
//

import UIKit
import Lottie

final class ChooseGameTypeView: UIViewController {

    // MARK: - Instance Properties

    let titleLabel = UILabel()
    let cashGameButton = UIButton()
    let rulesButton = UIButton()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
    }

    // MARK: - Instance Methods

    private func setupInitialState() {
        view.backgroundColor = .white

        titleLabel.text = "Начать игру"
        titleLabel.font = .boldSystemFont(ofSize: 25)

        cashGameButton.setTitle("Кэш-игра", for: .normal)
        cashGameButton.configuration?.contentInsets = .init(top: 3, leading: 5, bottom: 3, trailing: 5)
        cashGameButton.backgroundColor = .black
        cashGameButton.setTitleColor(.white, for: .normal)
        cashGameButton.layer.cornerRadius = 45 / 2
        cashGameButton.clipsToBounds = true
        cashGameButton.addTarget(self, action: #selector(didTapCashButton), for: .touchUpInside)

        rulesButton.setTitle("Правила игры", for: .normal)
        rulesButton.configuration?.contentInsets = .init(top: 1, leading: 5, bottom: 1, trailing: 5)
        rulesButton.backgroundColor = .black
        rulesButton.setTitleColor(.white, for: .normal)
        rulesButton.layer.cornerRadius = 50 / 2
        rulesButton.clipsToBounds = true
        rulesButton.addTarget(self, action: #selector(didTapRulesButton), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(cashGameButton)
        view.addSubview(rulesButton)

        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25)

        cashGameButton.autoCenterInSuperview()
        cashGameButton.autoSetDimensions(to: .init(width: 100, height: 45))

        rulesButton.autoAlignAxis(.vertical, toSameAxisOf: view)
        rulesButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        rulesButton.autoSetDimensions(to: .init(width: 150, height: 50))
    }

    // MARK: - Actions

    @objc private func didTapCashButton() {
        let viewController = StartGameView()

        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func didTapRulesButton() {
        let viewController = BaseWebView()

        viewController.configure(with: Constants.gameRulesURL)

        present(viewController, animated: true)
    }
}
