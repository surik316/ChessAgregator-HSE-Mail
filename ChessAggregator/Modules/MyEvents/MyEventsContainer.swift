//
//  MyEventsContainer.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import UIKit
import FirebaseAuth

final class MyEventsContainer {
    let input: MyEventsModuleInput
	let viewController: UIViewController
	private(set) weak var router: MyEventsRouterInput!

	static func assemble(with context: MyEventsContext) -> MyEventsContainer {
        let router = MyEventsRouter()
        let interactor = MyEventsInteractor()
        let presenter = MyEventsPresenter(router: router, interactor: interactor)
		let viewController = MyEventsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return MyEventsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MyEventsModuleInput, router: MyEventsRouterInput) {
		viewController = view
        self.input = input
		self.router = router
	}
}

struct MyEventsContext {
	weak var moduleOutput: MyEventsModuleOutput?
}
