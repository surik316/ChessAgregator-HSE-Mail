//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation

protocol UserRegistrationModuleInput: class {
    var moduleOutput: UserRegistrationModuleOutput? { get }
}

protocol UserRegistrationModuleOutput: class {
    func didRegister()
}

protocol UserRegistrationViewInput: class {
    func showLastNameWarning(isHidden: Bool)
    func showFirstNameWarning(isHidden: Bool)
    func showEmailWarning(isHidden: Bool)
    func showPasswordWarning(isHidden: Bool)
    func showValidatePasswordWarning(isHidden: Bool)
    func showOrganizationNameWarning(isHidden: Bool)
    func showEmailWasRegisteredWarning(withWarning: String, isHidden: Bool)
}

protocol UserRegistrationViewOutput: class {
    func onTapRegistration(lastName: String?, firstName: String?, patronymicName: String?, fideID: String?,
                           frcID: String?, email: String?, password: String?, passwordValidation: String?,
                           isOrganizer: Bool, organizationCity: String?, organizationName: String?, birthdate: Date,
                           sex: String?, latinName: String?
    )
    func onTapFide()
    func onTapFrc()
    func onTapLatinFullname()
    func isFullNameOK(string: String) -> Bool
    func filterID(string: String, maxID: Int) -> (Bool, Int?)
    func isLoginDataOK(string: String) -> Bool
    func isOrganizationDataOK(string: String) -> Bool
    func isSexOK(string: String) -> Bool
}

protocol UserRegistrationInteractorInput: class {
    func addToDataBase(userReg: UserReg)
}

protocol UserRegistrationInteractorOutput: class {
    func failedToAddAuthUser(error: String)
    func didRegister()
}

protocol UserRegistrationRouterInput: class {
    func showFide()
    func showFrc()
    func showFullname()
}
