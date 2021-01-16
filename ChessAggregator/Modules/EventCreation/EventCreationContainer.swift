//
//  EventCreationContainer.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import UIKit

final class EventCreationContainer {
    let input: EventCreationModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventCreationRouterInput!

	static func assemble(with context: EventCreationContext) -> EventCreationContainer {
        let router = EventCreationRouter()
        let interactor = EventCreationInteractor()
        let presenter = EventCreationPresenter(router: router, interactor: interactor)
		let viewController = EventCreationViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
		router.navigationControllerProvider = { [weak viewController] in
			viewController?.navigationController
		}

		interactor.output = presenter

        return EventCreationContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventCreationModuleInput, router: EventCreationRouterInput) {
		viewController = view
        self.input = input
		self.router = router
	}
}

struct EventCreationContext {
	weak var moduleOutput: EventCreationModuleOutput?
}
