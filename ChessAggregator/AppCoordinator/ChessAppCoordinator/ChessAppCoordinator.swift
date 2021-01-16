//
// Created by Иван Лизогуб on 29.11.2020.
//

import UIKit

final class ChessAppCoordinator {
    private let window: UIWindow
    weak var appCoordinator: ChessAppCoordinatorModuleOutput?
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = ChessAppCoordinator.makeNavigationControllers()

    init(window: UIWindow,  appCoordinator: ChessAppCoordinatorModuleOutput) {
        self.appCoordinator = appCoordinator
        self.window = window
        setupAppearance()
    }

    func startApp() {
        setupSearch()
        setupProfile()
        setupTournament()

        let navigationControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }
}

private extension ChessAppCoordinator {
    func setupTournament() {
        guard let navController = navigationControllers[.currentTournaments] else {
            fatalError("wtf no Current")
        }
        let context = MyEventsContext(moduleOutput: nil)
        let container = MyEventsContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.currentTournaments.title
    }

    func setupSearch() {
        guard let navController = navigationControllers[.search] else {
            fatalError("wtf no Search")
        }

        let context = SearchTournamentsContext(moduleOutput: nil)

        let container = SearchTournamentsContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.search.title
    }

    func setupProfile() {
        guard let navController = navigationControllers[.profile] else {
            fatalError("wtf no Profile")
        }
        let context = UserProfileContext(moduleOutput: nil)

        let container = UserProfileContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.profile.title
    }

    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white

            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().barTintColor = .blue
            UINavigationBar.appearance().isTranslucent = false
        }
        UINavigationBar.appearance().shadowImage = UIImage()

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        ]

        UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        ], for: .normal)


        UITabBar.appearance().barTintColor = .white
    }

    static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: navControllerKey.title,
                    image: navControllerKey.image,
                    tag: navControllerKey.rawValue)
            navigationController.tabBarItem = tabBarItem
            result[navControllerKey] = navigationController

            navigationController.isNavigationBarHidden = true // MARK: делать false при переходах
        }
        return result
    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case currentTournaments, search, profile

    var title: String {
        switch self {
        case .currentTournaments:
            return Localization.currentTournaments
        case .search:
            return Localization.search
        case .profile:
            return Localization.profile
        }
    }

    var image: UIImage? {
        switch self {
        case .currentTournaments:
            return UIImage(systemName: "crown")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .profile:
            return UIImage(systemName: "person")
        }
    }
}


enum Localization {
    static let currentTournaments = "Турниры"
    static let search = "Лента"
    static let profile = "Профиль"
}
