//
//  MainTabBar.swift
//  PokerHelper
//
//  Created by Nikita Luzhbin on 16.08.2022.
//

import UIKit

final class MainTabBar: UITabBarController {

    // MARK: - Instance Proeprties

    private lazy var chooseGameViewController: UIViewController = {
        let viewController = ChooseGameTypeView()

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .black

        navigationController.tabBarItem.title = "Игра"
        navigationController.tabBarItem.image = UIImage(systemName: "gamecontroller")

        return navigationController
    }()

    private lazy var archiveViewController: UIViewController = {
        let viewController = ArchiveView()

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .black

        navigationController.view.backgroundColor = .white
        navigationController.tabBarItem.title = "Архив"
        navigationController.tabBarItem.image = UIImage(systemName: "rectangle.stack")

        return navigationController
    }()

    private lazy var settingsViewController: SettingsViewController = {
        let settingsViewController = SettingsViewController()

        settingsViewController.view.backgroundColor = .white
        settingsViewController.tabBarItem.title = "Настройки"
        settingsViewController.tabBarItem.image = UIImage(systemName: "gearshape")

        return settingsViewController
    }()

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInitialState()
        self.setupViewControllers()
    }

    // MARK: - Instance Methods

    private func setupInitialState() {
        self.tabBar.tintColor = .black

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            fatalError("Should check tabbar appearance in iOS 15 less")
        }
    }

    private func setupViewControllers() {
        self.viewControllers = [self.chooseGameViewController,
                                self.archiveViewController,
                                self.settingsViewController]
    }
}

