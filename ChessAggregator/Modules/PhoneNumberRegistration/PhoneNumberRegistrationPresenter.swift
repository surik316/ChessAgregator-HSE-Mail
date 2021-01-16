//
//  PhoneNumberRegistrationPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import Foundation
import FirebaseAuth


final class PhoneNumberRegistrationPresenter {
	weak var view: PhoneNumberRegistrationViewInput?
    weak var moduleOutput: PhoneNumberRegistrationModuleOutput?
    
	private let router: PhoneNumberRegistrationRouterInput
	private let interactor: PhoneNumberRegistrationInteractorInput
    
    init(router: PhoneNumberRegistrationRouterInput, interactor: PhoneNumberRegistrationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PhoneNumberRegistrationPresenter: PhoneNumberRegistrationModuleInput {
}

extension PhoneNumberRegistrationPresenter: PhoneNumberRegistrationViewOutput {
    
    
    
    func onTapGet(withPhoneNumber phoneNumber: String?) {
        
        if let number = phoneNumber, interactor.isPhoneNumberValid(phoneNumber: number) {
            
            view?.showWarning(isHidden: true)
            view?.showVerificationField(isHidden: false)
            view?.changeGetButton()
            view?.GetButtonFlag_setter()
            
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) {
                (verificationID, error) in
                
                if error != nil {
                    print(error?.localizedDescription ?? "is empty")
                } else {
                    self.view?.setVerificationID(verificationID: verificationID)
                }
            }
        } else {
            view?.showWarning(isHidden: false)
            view?.showVerificationField(isHidden: true)
        }
    }
    
    func onTapFlag() {
        router.showCountryList()
    }

    func onTapNext(withPhoneNumber phoneNumber: String?) {
        if let number = phoneNumber, interactor.isPhoneNumberValid(phoneNumber: number) {
            view?.showWarning(isHidden: true)
            view?.showVerificationWarning(isHidden: true)
            
            view?.checkCode()
            if view?.getCodeStatus() == true {
                //moduleOutput?.setRegPhoneNumber(phoneNumber: number)
                moduleOutput?.showSignUp()

            } else {
                view?.showVerificationWarning(isHidden: false)
            }
        } else {
            view?.showWarning(isHidden: false)
        }
    }

}

extension PhoneNumberRegistrationPresenter: PhoneNumberRegistrationInteractorOutput {
}
