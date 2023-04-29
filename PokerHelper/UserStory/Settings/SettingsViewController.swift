//
//  SettingsViewController.swift
//  PokerHelper
//
//  Created by Nikita Luzhbin on 16.08.2022.
//

import UIKit
import PureLayout

final class SettingsViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private lazy var underDevelopmentView = UnderDevelopmentView()

    // MARK: -

    private var currentBool: Bool = false
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInisialState()
    }
    
    // MARK: - Instance Methods
    
    private func setupInisialState() {
        self.view.addSubview(self.underDevelopmentView)

        self.underDevelopmentView.autoPinEdgesToSuperviewEdges()
    }
}
