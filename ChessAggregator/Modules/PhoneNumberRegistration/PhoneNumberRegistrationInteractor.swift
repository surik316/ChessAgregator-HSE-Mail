//
// Created by Иван Лизогуб on 23.11.2020.
//

import Foundation

final class PhoneNumberRegistrationInteractor {
    weak var output: PhoneNumberRegistrationInteractorOutput?
}

extension PhoneNumberRegistrationInteractor: PhoneNumberRegistrationInteractorInput {
    func isPhoneNumberValid(phoneNumber: String) -> Bool {
        //implementation
        return true
    }
}
