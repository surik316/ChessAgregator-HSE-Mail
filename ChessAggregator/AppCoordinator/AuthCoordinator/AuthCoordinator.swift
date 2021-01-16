//
// Created by Иван Лизогуб on 29.11.2020.
//

import UIKit

final class AuthCoordinator {
    private let window: UIWindow
    private var navigationController = UINavigationController()
    weak var appCoordinator: AuthCoordinatorModuleOutput?
    var phoneNumber: String?

    init(window: UIWindow, appCoordinator: AuthCoordinatorModuleOutput) {
        self.window = window
        self.appCoordinator = appCoordinator
    }


    func auth() {
        let context = AuthContext(moduleOutput: self)
        let container = AuthContainer.assemble(with: context)
        navigationController.setViewControllers([container.viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func ForgotPassword() {
        let context = ForgotPasswordContext(moduleOutput: self)
        let container = ForgotPasswordContainer.assemble(with: context)
        navigationController.pushViewController(container.viewController, animated: true)
    }


    func userRegistrationSignUp() {
        let context = UserRegistrationContext(moduleOutput: self)
        let container = UserRegistrationContainer.assemble(with: context)
        navigationController.pushViewController(container.viewController, animated: true)
    }
}

extension AuthCoordinator: AuthModuleOutput {

    func showForgotPassword() {
        ForgotPassword()
    }

    func showSignUp() {
        userRegistrationSignUp()
    }

    func didLogin() {
        appCoordinator?.didLogin()
    }

}

extension AuthCoordinator: ForgotPasswordModuleOutput {
    func showForgot() {
    }
}

extension AuthCoordinator: UserRegistrationModuleOutput {
    func didRegister() {
        appCoordinator?.didLogin()
    }
}
