//
//  Alertable.swift
//  PokerHelper
//
//  Created by Никита Лужбин on 02.01.2023.
//

import Foundation
import UIKit
import Combine

extension UIViewController {

    // MARK: - Type Properties

    struct AlertAction {
        let title: String
        var action: (() -> Void)? = nil
    }

    struct AlertTextField {
        let placeholder: String
        let type: UIKeyboardType
        var isAutocapitalizationEnabled: Bool = false
    }

    // MARK: - Instance Methods

    func showAlert(title: String? = nil,
                   message: String? = nil,
                   isCancellable: Bool = false,
                   actions: [AlertAction] = []) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        alertController.view.tintColor = .black

        for actionModel in actions {
            alertController.addAction(.init(title: actionModel.title,
                                            style: .default,
                                            handler: { _ in
                actionModel.action?()
            }))
        }

        if isCancellable {
            alertController.addAction(.init(title: "Отмена", style: .cancel))
        }

        present(alertController, animated: true)
    }

    func showAlert(title: String? = nil,
                   message: String? = nil,
                   textFields: [AlertTextField] = [],
                   isCancellable: Bool = false,
                   completion: @escaping ([String]) -> Void) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        alertController.view.tintColor = .black

        for textFieldModel in textFields {
            alertController.addTextField { textField in
                textField.keyboardType = textFieldModel.type
                textField.placeholder = textFieldModel.placeholder
                textField.autocapitalizationType = textFieldModel.isAutocapitalizationEnabled ? .words : .none
            }
        }

        if isCancellable {
            alertController.addAction(.init(title: "Отмена", style: .cancel))
        }

        alertController.addAction(.init(title: "Ок", style: .default, handler: { _ in
            completion(alertController.textFields?.compactMap { $0.text } ?? [])
        }))

        present(alertController, animated: true)
    }
}
