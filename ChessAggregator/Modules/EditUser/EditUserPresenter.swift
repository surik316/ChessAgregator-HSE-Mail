//
//  EditUserPresenter.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation

final class EditUserPresenter {
	weak var view: EditUserViewInput?
    weak var moduleOutput: EditUserModuleOutput?
    var user: User?

    private let router: EditUserRouterInput
	private let interactor: EditUserInteractorInput


    init(router: EditUserRouterInput, interactor: EditUserInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditUserPresenter: EditUserModuleInput {
}

extension EditUserPresenter: EditUserViewOutput {
    func close() {
        router.close()
    }

    func saveChanges() {
        if let userInfo = user {
            interactor.saveChanges(with: userInfo)
            router.close()
        } else {
            print("Didn't save anything")
        }
    }

    func editUser(with user: User) {
        self.user = user
        saveChanges()
    }

    func userState() -> User {
        user ?? User()
    }

}

extension EditUserPresenter: EditUserInteractorOutput {
}
