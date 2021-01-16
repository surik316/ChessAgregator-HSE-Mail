//
//  ForgotPasswordInteractor.swift
//  ChessAggregator
//
//  Created by Гарик  on 06.12.2020.
//

import Foundation



import Firebase

class ForgotPasswordInteractor {
    weak var output: ForgotPasswordInteractorOutput?

}

extension ForgotPasswordInteractor: ForgotPasswordInteractorInput {
    func addToDataBase(user: UserForgot) {
        Auth.auth().sendPasswordReset(withEmail: user.email!){ (error) in
            if error != nil{
                print("Reset failed")
            }
        }
    }
}
