//
//  EventApplicationContainer.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import UIKit

final class EventApplicationContainer {
    let input: EventApplicationModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventApplicationRouterInput!

	static func assemble(with context: EventApplicationContext) -> EventApplicationContainer {
        let router = EventApplicationRouter()
        let interactor = EventApplicationInteractor(tournament: context.tournament)
        let presenter = EventApplicationPresenter(router: router, interactor: interactor)
		let viewController = EventApplicationViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

		router.navigationControllerProvider = { [weak viewController] in
			viewController?.navigationController
		}

        return EventApplicationContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventApplicationModuleInput, router: EventApplicationRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventApplicationContext {
	weak var moduleOutput: EventApplicationModuleOutput?
	let tournament: Tournament
}
