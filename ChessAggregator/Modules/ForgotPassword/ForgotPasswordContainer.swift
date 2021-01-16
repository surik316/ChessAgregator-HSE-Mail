//
//  ForgotPasswordContainer.swift
//  ChessAggregator
//
//  Created by Гарик  on 06.12.2020.
//

import UIKit

class ForgotPasswordContainer {
    let input: ForgotPasswordModuleInput
    let viewController: UIViewController
    private(set) weak var router: ForgotPasswordRouterInput!

    class func assemble(with context: ForgotPasswordContext) -> ForgotPasswordContainer {
        let router = ForgotPasswordRouter()
        let interactor = ForgotPasswordInteractor()
        let presenter = ForgotPasswordPresenter(router: router, interactor: interactor)
        let viewController = ForgotPasswordViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter

        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }

        return ForgotPasswordContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController,
                 input: ForgotPasswordModuleInput,
                 router: ForgotPasswordRouterInput) {

        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ForgotPasswordContext {
    weak var moduleOutput: ForgotPasswordModuleOutput?

}
