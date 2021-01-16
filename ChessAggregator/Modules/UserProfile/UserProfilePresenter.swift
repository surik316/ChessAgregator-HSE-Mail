

import Foundation
import Firebase
final class UserProfilePresenter {
	weak var view: UserProfileViewInput?
    weak var moduleOutput: UserProfileModuleOutput?
    
	private let router: UserProfileRouterInput
	private let interactor: UserProfileInteractorInput
    private var user: User?
    
    init(router: UserProfileRouterInput, interactor: UserProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension UserProfilePresenter: UserProfileModuleInput {
}

extension UserProfilePresenter: UserProfileViewOutput {
    

    func editProfile() {
        if let userInfo = user {
            router.showEditor(with: userInfo)
            //interactor.reloadData()
        }

    }

    func createEvent() {
        router.showCreator()
    }


    func showFIDE() {
        if let userInfo = user {
            router.showFIDE(user: userInfo)
        }
    }

    func showFRC() {
        if let userInfo = user {
            router.showFRC(user: userInfo)
        } else {

        }
    }
    func signOut() {
        let auth = Auth.auth()
        do{
            try auth.signOut()
        }catch let signOutError{
            print("Error: \(signOutError)")
        }
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    func updateUser(user: User) {
        self.user = user
        let userViewModel = makeViewModel(user: user)
        view!.updateUser(user: userViewModel)
    }
}

private extension UserProfilePresenter {
    func makeViewModel(user: User) -> UserViewModel {
        UserViewModel(
                userName: user.player.lastName + " " + user.player.firstName,
                userStatus: user.isOrganizer ? "Организатор" : "Игрок",
                classicFideRating: String(user.player.classicFideRating ?? 0),
                rapidFideRating: String(user.player.rapidFideRating ?? 0),
                blitzFideRating: String(user.player.blitzFideRating ?? 0),
                classicFrcRating: String(user.player.classicFrcRating ?? 0),
                rapidFrcRating: String(user.player.rapidFrcRating ?? 0),
                blitzFrcRating: String(user.player.blitzFrcRating ?? 0),
                isOrganizer: user.isOrganizer)
    }
}