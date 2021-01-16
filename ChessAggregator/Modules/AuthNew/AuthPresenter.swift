//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit
class AuthPresenter {
    weak var view: AuthViewInput?
    weak var moduleOutput: AuthModuleOutput?

    private let router: AuthRouterInput
    private let interactor: AuthInteractorInput

    init(router: AuthRouterInput, interactor: AuthInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthModuleInput {

}

extension AuthPresenter: AuthViewOutput {
    
    func onTapLogin(email: String, password: String) {
        interactor.signIn(withEmail: email, password: password)
    }
    func onTapForgot() {
        moduleOutput?.showForgotPassword()
        router.showNavigationBar()
    }
    func onTapSignUp() {
        moduleOutput?.showSignUp()
        router.showNavigationBar()
    }
}

extension AuthPresenter: AuthInteractorOutput {
    func didLogin() {
        moduleOutput?.didLogin()
    }
    func showError(error: String) {
        router.showAllert(error: error)
    }
}
