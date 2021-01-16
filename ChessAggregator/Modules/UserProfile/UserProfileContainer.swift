

import UIKit

final class UserProfileContainer {
    let input: UserProfileModuleInput
	let viewController: UIViewController
	private(set) weak var router: UserProfileRouterInput!

	static func assemble(with context: UserProfileContext) -> UserProfileContainer {
        let router = UserProfileRouter()  //TODO: номер телефона
        let interactor = UserProfileInteractor()
        let presenter = UserProfilePresenter(router: router, interactor: interactor)
		let viewController = UserProfileViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

		router.navigationControllerProvider = {[weak viewController] in
			viewController?.navigationController
		}

        return UserProfileContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: UserProfileModuleInput, router: UserProfileRouterInput) {
		viewController = view
        self.input = input
		self.router = router
	}
}

struct UserProfileContext {
	weak var moduleOutput: UserProfileModuleOutput?
	  //TODO: номер телефона
}
