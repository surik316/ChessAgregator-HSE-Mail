//
//  EditUserContainer.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import UIKit

final class EditUserContainer {
    let input: EditUserModuleInput
	let viewController: UIViewController
	private(set) weak var router: EditUserRouterInput!

	static func assemble(with context: EditUserContext) -> EditUserContainer {
        let router = EditUserRouter()
        let interactor = EditUserInteractor()
        let presenter = EditUserPresenter(router: router, interactor: interactor)
		let viewController = EditUserViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
		presenter.user = context.user

		interactor.output = presenter

		router.navigationControllerProvider = { [weak viewController] in
			viewController?.navigationController
		}

        return EditUserContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EditUserModuleInput, router: EditUserRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EditUserContext {
	weak var moduleOutput: EditUserModuleOutput?
	var user: User
}
