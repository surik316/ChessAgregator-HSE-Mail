//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit
class AuthRouter: BaseRouter {

}

extension AuthRouter: AuthRouterInput {
    func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }

    func showAllert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

