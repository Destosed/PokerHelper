//
//  BaseWebView.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 02.01.2023.
//

import UIKit
import WebKit
import PureLayout

final class BaseWebView: UIViewController {

    // MARK: - Instance Properties

    private let webView = WKWebView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
    }

    override func loadView() {
        view = webView
    }

    // MARK: - Instance Methods

    func configure(with url: String) {
        guard let url = URL(string: url) else {
            dismiss(animated: true)
            return
        }

        webView.load(.init(url: url))
    }

    // MARK: -

    private func setupInitialState() { }
}
