//
//  EditUserInteractor.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class EditUserInteractor {
	weak var output: EditUserInteractorOutput?
}

extension EditUserInteractor: EditUserInteractorInput {
	func saveChanges(with user: User) {
		let realtimeDatabaseUser = UserParser.userToFirebaseUser(user: user)
		FirebaseRef.ref.child("Users").child(Auth.auth().currentUser!.uid).setValue(realtimeDatabaseUser)
        print("Some extremely important changes have deployed for \(user.player.firstName)")
	}

}
