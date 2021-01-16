
import Foundation
import FirebaseAuth

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
	var user: User?

	init() {

        FirebaseRef.ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").observe(.value) { [weak self] snapshot in
			self?.user = UserParser.userFromSnapshot(snapshot: snapshot)

            let ratings = UserParser.RateParser(frcID: self?.user?.player.frcID ?? 0)
            self?.user?.player.classicFideRating = ratings[3]
            self?.user?.player.rapidFideRating = ratings[4]
            self?.user?.player.blitzFideRating = ratings[5]
            self?.user?.player.classicFrcRating = ratings[0]
            self?.user?.player.rapidFrcRating = ratings[1]
            self?.user?.player.blitzFrcRating = ratings[2]

//            let realtimeDatabaseUser = UserParser.userToFirebaseUser(user: self?.user ?? User())
//            FirebaseRef.ref.child("Users").child(Auth.auth().currentUser!.uid).setValue(realtimeDatabaseUser)

			self?.output!.updateUser(user: self!.user!)
		}
	}
}

extension UserProfileInteractor: UserProfileInteractorInput {

}
