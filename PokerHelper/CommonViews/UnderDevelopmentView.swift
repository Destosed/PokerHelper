//
//  UnderDevelopmentView.swift
//  PokerHelper
//
//  Created by Nikita Luzhbin on 16.08.2022.
//

import Foundation
import UIKit

final class UnderDevelopmentView: UIView {

    // MARK: - Instance Properties

    private lazy var gearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "gear.badge.questionmark"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "В разработке..."
        textLabel.font = .systemFont(ofSize: 22)

        return textLabel
    }()

    // MARK: - Instance Methods

    private func setupInitialState() {
        addSubview(self.gearImageView)
        addSubview(self.textLabel)

        gearImageView.autoSetDimensions(to: .init(width: 100, height: 100))
        gearImageView.autoCenterInSuperview()

        textLabel.autoPinEdge(.top, to: .bottom, of: gearImageView, withOffset: 15)
        textLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
