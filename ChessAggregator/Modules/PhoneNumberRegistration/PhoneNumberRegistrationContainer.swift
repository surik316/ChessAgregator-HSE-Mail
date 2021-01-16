//
//  PhoneNumberRegistrationContainer.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import UIKit

final class PhoneNumberRegistrationContainer {
    let input: PhoneNumberRegistrationModuleInput
	let viewController: UIViewController
	private(set) weak var router: PhoneNumberRegistrationRouterInput!

	static func assemble(with context: PhoneNumberRegistrationContext) -> PhoneNumberRegistrationContainer {
        let router = PhoneNumberRegistrationRouter()
        let interactor = PhoneNumberRegistrationInteractor()
        let presenter = PhoneNumberRegistrationPresenter(router: router, interactor: interactor)
		let viewController = PhoneNumberRegistrationViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

		router.navigationControllerProvider = { [weak viewController] in
			viewController?.navigationController
		}
		router.listController = viewController.getListFpnVC()

        return PhoneNumberRegistrationContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: PhoneNumberRegistrationModuleInput, router: PhoneNumberRegistrationRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct PhoneNumberRegistrationContext {
	weak var moduleOutput: PhoneNumberRegistrationModuleOutput?
}
