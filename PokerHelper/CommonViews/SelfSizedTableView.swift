//
//  SelfResizedTableView.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 03.01.2023.
//

import Foundation
import UIKit

final class SelfSizedTableView: UITableView {

    // MARK: - Instance Properties

    var maxHeight: CGFloat = UIScreen.main.bounds.size.height

    // MARK: - UITableView
    
    override func reloadData() {
        super.reloadData()

        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
