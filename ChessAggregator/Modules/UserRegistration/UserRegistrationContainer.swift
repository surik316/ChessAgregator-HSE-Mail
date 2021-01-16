//
// Created by Иван Лизогуб on 14.11.2020.
//

import UIKit

class UserRegistrationContainer {
    let input: UserRegistrationModuleInput
    let viewController: UIViewController
    private(set) weak var router: UserRegistrationRouterInput!

    class func assemble(with context: UserRegistrationContext) -> UserRegistrationContainer {
        let router = UserRegistrationRouter()
        let interactor = UserRegistrationInteractor()
        let presenter = UserRegistrationPresenter(router: router, interactor: interactor)
        let viewController = UserRegistrationViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter

        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }

        return UserRegistrationContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController,
                 input: UserRegistrationModuleInput,
                 router: UserRegistrationRouterInput) {

        viewController = view
        self.input = input
        self.router = router
    }
}

struct UserRegistrationContext {
    weak var moduleOutput: UserRegistrationModuleOutput?
    //var phoneNumber: String
}
