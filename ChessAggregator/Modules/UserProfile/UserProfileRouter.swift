
import UIKit
import SafariServices

final class UserProfileRouter: BaseRouter {
     //TODO: номер телефона

     //TODO: номер телефона
    
}

extension UserProfileRouter: UserProfileRouterInput {
    
    func showEditor(with user: User) {
        let context = EditUserContext(moduleOutput: nil, user: user) // TODO: output
        let container = EditUserContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true) // UPDATE VIEW AFTERWARDS
        
    }

    func showCreator() {
        let context = EventCreationContext(moduleOutput: nil)
        let container = EventCreationContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }

    func showFIDE(user: User) {
        guard let id = user.player.fideID else {
            print("У вас не указан FIDE id. Если он существует, укажите его в профиле!")
            // TODO: Сделать алерт, если у игрока нет fide id
            return
        }
        let fideString = "https://ratings.fide.com/profile/" + String(id)
        let fideURL = URL(string: fideString) ?? URL(string: "https://vk.com/oobermensch")!
        let fideViewController = SFSafariViewController(url: fideURL)
        navigationController?.present(fideViewController, animated: true)
    }

    func showFRC(user: User) {
        guard let id = user.player.frcID else {
            print("У вас не указан ФШР id. Если он существует, укажите его в профиле!")
            return
            // TODO: Сделать алерт, если у игрока нет фшр id
        }
        let frcString = "https://ratings.ruchess.ru/people/" + String(id)
        let frcURL = URL(string: frcString) ?? URL(string: "https://vk.com/oobermensch")!
        let frcViewController = SFSafariViewController(url: frcURL)
        navigationController?.present(frcViewController, animated: true)
    }
}
