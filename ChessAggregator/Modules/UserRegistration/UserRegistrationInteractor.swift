//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import Firebase

class UserRegistrationInteractor {
    weak var output: UserRegistrationInteractorOutput?
}

extension UserRegistrationInteractor: UserRegistrationInteractorInput {
    func addToDataBase(userReg: UserReg) {
        var user = createUserEntity(userReg: userReg)
        Auth.auth().createUser(
                withEmail: user.email,
                password: userReg.password
        ) { [weak self] authResult, error in
            if let firebaseUser = authResult?.user, error == nil {

                let ratings = UserParser.RateParser(frcID: user.player.frcID ?? 0)
                user.player.classicFideRating = ratings[3]
                user.player.rapidFideRating = ratings[4]
                user.player.blitzFideRating = ratings[5]
                user.player.classicFrcRating = ratings[0]
                user.player.rapidFrcRating = ratings[1]
                user.player.blitzFrcRating = ratings[2]

                let realtimeDatabaseUser = UserParser.userToFirebaseUser(user: user)


                FirebaseRef.ref.child("Users").child(firebaseUser.uid).setValue(realtimeDatabaseUser)
                self?.signIn(withEmail: user.email, password: userReg.password)
            } else {
                self?.output?.failedToAddAuthUser(error: error?.localizedDescription ?? "saving user error")
            }
        }
    }

    private func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self?.output?.didRegister()
            }
        }
    }
}


private extension UserRegistrationInteractor {
    func createUserEntity(userReg: UserReg) -> User {
        let user = User(
                player: Player(
                        lastName: userReg.lastName, firstName: userReg.firstName,
                        patronomicName: userReg.patronymicName, birthdate: userReg.birthdate, sex: userReg.sex,
                        latinName: userReg.latinName, fideID: Int(userReg.fideID), frcID: Int(userReg.frcID)
                ),
                email: userReg.email, isOrganizer: userReg.isOrganizer,
                organizer: Organizer(organizationCity: userReg.organisationCity, organizationName: userReg.organisationName))

        return user
    }
}
