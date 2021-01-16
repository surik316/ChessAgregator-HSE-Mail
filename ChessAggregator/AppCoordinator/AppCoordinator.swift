//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private var authCoordinator: AuthCoordinator?
    private var chessAppCoordinator: ChessAppCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func auth() {
        authCoordinator = AuthCoordinator(window: window, appCoordinator: self)
        authCoordinator?.auth()
    }


    func startApp() {
        chessAppCoordinator = ChessAppCoordinator(window: window, appCoordinator: self)
        chessAppCoordinator?.startApp()

    }

}

extension AppCoordinator: AuthCoordinatorModuleOutput {

    func didLogin() {
        startApp()
    }

}

extension AppCoordinator: ChessAppCoordinatorModuleOutput {

}
