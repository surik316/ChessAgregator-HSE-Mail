//
// Created by Иван Лизогуб on 18.11.2020.
//

import FirebaseAuth
import Foundation
class AuthInteractor {
    weak var output: AuthInteractorOutput?

}

extension AuthInteractor: AuthInteractorInput {
    func forgot() {

    }


    func signIn(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self?.output?.showError(error: "Invalid email")

                    case .wrongPassword:
                        self?.output?.showError(error: "Invalid password")
                    default:
                        self?.output?.showError(error: "Other Error!")

                    }
                }
            } else {
                self?.output?.didLogin()
            }
        }


    }
}