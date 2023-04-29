//
//  PlayerCell.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 25.12.2022.
//

import Foundation
import PureLayout

final class PlayerCell: UITableViewCell {

    // MARK: - Type Properties

    static let reuseIdentifier = "PlayerCell"

    // MARK: - Instance Properties

    private let nameLabel = UILabel()
    private let amountStack = UIStackView()
    private let amountLabel = UILabel()
    private let arrowImage = UIImageView()
    private let endAmountLabel = UILabel()
    

    // MARK: - UITableViewCell

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupInitialState()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Instance Methods

    private func setupInitialState() {
        amountStack.axis = .horizontal
        amountStack.spacing = 10

        arrowImage.image = .init(systemName: "arrow.forward")
        arrowImage.tintColor = .black
        arrowImage.isHidden = true

        endAmountLabel.isHidden = true
        
        addSubview(nameLabel)
        addSubview(amountStack)
        amountStack.addArrangedSubview(amountLabel)
        amountStack.addArrangedSubview(arrowImage)
        amountStack.addArrangedSubview(endAmountLabel)

        nameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

        amountLabel.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: 20)

        amountStack.autoAlignAxis(toSuperviewAxis: .horizontal)
        amountStack.autoPinEdge(toSuperviewEdge: .right, withInset: 20, relation: .greaterThanOrEqual)

        arrowImage.autoSetDimensions(to: .init(width: 20, height: 20))
    }

    // MARK: -

    func configure(for player: Player, isGameStarted: Bool) {
        nameLabel.text = player.name
        amountLabel.text = "\(player.amount) ₽"

        if isGameStarted {
            UIView.animate(withDuration: 0.25) {
                self.endAmountLabel.isHidden = false
                self.arrowImage.isHidden = false

                var endAmount: String {
                    if let endAmount = player.endAmount {
                        return String(endAmount)
                    } else {
                        return "?"
                    }
                }
                self.endAmountLabel.text = "\(endAmount) ₽"
            }
        }
    }
}
