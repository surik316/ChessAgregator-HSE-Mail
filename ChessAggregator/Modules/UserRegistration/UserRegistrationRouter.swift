//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import SafariServices
import UIKit

class UserRegistrationRouter: BaseRouter {

}

extension UserRegistrationRouter: UserRegistrationRouterInput {
    func showFide() {
        let fideUrl = URL(string: "https://ratings.fide.com/search.phtml") ?? URL(string: "https://www.google.com")!
        let fideViewController = SFSafariViewController(url: fideUrl)
        navigationController?.present(fideViewController, animated: true)
    }

    func showFrc() {
        let frcUrl = URL(string: "https://ratings.ruchess.ru") ?? URL(string: "https://www.google.com")!
        let frcViewController = SFSafariViewController(url: frcUrl)
        navigationController?.present(frcViewController, animated: true)
    }
    func showFullname() {
        
        let alert = UIAlertController(title: "Если нет FIDE/ФШР ID", message: "Для получения рейтинга необходимо указать Фамилию и Имя на английском языке", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: {
            action in
            alert.dismiss(animated: true, completion: nil)
        }))
        navigationController?.present(alert, animated: true, completion: nil)
    }

}
