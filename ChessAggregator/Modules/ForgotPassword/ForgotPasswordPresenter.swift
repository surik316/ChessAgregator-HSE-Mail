//
//  ForgotPasswordPresenter.swift
//  ChessAggregator
//
//  Created by Гарик  on 06.12.2020.
//

import Foundation

class ForgotPasswordPresenter {
    weak var view: ForgotPasswordViewInput?
    weak var moduleOutput: ForgotPasswordModuleOutput?

    private let interactor: ForgotPasswordInteractorInput
    private let router: ForgotPasswordRouterInput

    init(router: ForgotPasswordRouterInput, interactor: ForgotPasswordInteractorInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension ForgotPasswordPresenter: ForgotPasswordModuleInput {

}

extension ForgotPasswordPresenter: ForgotPasswordViewOutput {
    func onTapChange(email: String?) {
        let user = UserForgot(
                email: email)
        if isUserValid(with: user) {
            interactor.addToDataBase(user: user)
            print("start")
            // moduleOutput?.didRegister()
        } else {
            showWarnings(user: user)
        }
    }
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutput {

}

private extension ForgotPasswordPresenter {
    func isUserValid(with user: UserForgot) -> Bool {
        isEmailValid(with: user.email)
    }

    func isEmailValid(with emailAddress: String?) -> Bool {
        if let email = emailAddress {
            return email.isEmail()
        } else {
            return false
        }
    }

}

private extension ForgotPasswordPresenter {
    func showWarnings(user: UserForgot) {
        if isEmailValid(with: user.email) {
            view?.showEmailWarning(isHidden: true)
        } else {
            view?.showEmailWarning(isHidden: false)
        }

    }
}

private extension ForgotPasswordPresenter {

    func isStringNotEmpty(string: String?) -> Bool {
        guard let str = string else { return false }
        if str.isEmpty {
            return false
        } else {
            return true
        }
    }
}
