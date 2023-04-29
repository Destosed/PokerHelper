//
//  UnderDevelopment.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 04.01.2023.
//

import UIKit

extension UIViewController {

    // MARK: - Instance Methods

    func showUnderDevelopmentView() {
        let underDevelopmentView = UnderDevelopmentView()

        self.view.addSubview(underDevelopmentView)

        underDevelopmentView.autoPinEdgesToSuperviewEdges()
    }
}
