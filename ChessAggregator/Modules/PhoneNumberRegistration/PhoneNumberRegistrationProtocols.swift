//
//  PhoneNumberRegistrationProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import Foundation

protocol PhoneNumberRegistrationModuleInput {
	var moduleOutput: PhoneNumberRegistrationModuleOutput? { get }
}

protocol PhoneNumberRegistrationModuleOutput: class {
	func showSignUp()
	//func setRegPhoneNumber(phoneNumber: String)
}

protocol PhoneNumberRegistrationViewInput: class {
	func showWarning(isHidden: Bool)
    func showVerificationField(isHidden: Bool)
    func changeGetButton()
    func GetButtonFlag_getter()->Bool
    func GetButtonFlag_setter()
    func checkCode()
    func getCodeStatus()-> Bool
    func setVerificationID(verificationID: String?)
    func showVerificationWarning(isHidden: Bool)
}

protocol PhoneNumberRegistrationViewOutput: class {
	func onTapNext(withPhoneNumber: String?)
    func onTapGet(withPhoneNumber: String?)
	func onTapFlag()
}

protocol PhoneNumberRegistrationInteractorInput: class {
	func isPhoneNumberValid(phoneNumber: String) -> Bool
}

protocol PhoneNumberRegistrationInteractorOutput: class {
}

protocol PhoneNumberRegistrationRouterInput: class {
	func showCountryList()
}
