//
//  ForgotPasswordProtocol.swift
//  ChessAggregator
//
//  Created by Гарик  on 06.12.2020.
//

import Foundation

protocol ForgotPasswordModuleInput: class {
    var moduleOutput: ForgotPasswordModuleOutput? { get }
}

protocol ForgotPasswordModuleOutput: class {
    func didRegister()
}

protocol ForgotPasswordViewInput: class {
    func showEmailWarning(isHidden: Bool)

}

protocol ForgotPasswordViewOutput: class {
    func onTapChange(
            email: String?
    )

}

protocol ForgotPasswordInteractorInput: class {
    func addToDataBase(user: UserForgot)
}

protocol ForgotPasswordInteractorOutput: class {

}

protocol ForgotPasswordRouterInput: class {

}
