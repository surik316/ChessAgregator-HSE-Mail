//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation

protocol AuthModuleInput: class {
    var moduleOutput: AuthModuleOutput? { get }
}

protocol AuthModuleOutput: class {
    func didLogin()
    func showForgotPassword()
    func showSignUp()
}

protocol AuthViewInput: class {

}

protocol AuthViewOutput: class {
    func onTapLogin(email: String, password: String)
    func onTapSignUp()
    func onTapForgot()
}

protocol AuthInteractorInput: class {
    func signIn(withEmail: String, password: String)
    func forgot()
}

protocol AuthInteractorOutput: class {
    func didLogin()
    func showError(error: String)
}

protocol AuthRouterInput: class {
    func showAllert(error: String)
    func showNavigationBar()
}
