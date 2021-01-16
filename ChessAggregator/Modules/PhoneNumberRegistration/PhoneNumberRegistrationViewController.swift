//
//  PhoneNumberRegistrationViewController.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth

final class PhoneNumberRegistrationViewController: UIViewController {
	private let output: PhoneNumberRegistrationViewOutput

    private let phoneView = PhoneNumberRegistrationView()

    init(output: PhoneNumberRegistrationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = phoneView
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setup()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    private func setup() {


        phoneView.numberFPNTextField.delegate = self
        phoneView.verificationCodeTextField.delegate = self
       


        phoneView.onTapNextButton = { [weak self]
        phoneNumber in
            self?.output.onTapNext(withPhoneNumber: phoneNumber)
        }
        
        self.phoneView.onTapGetButton = { [weak self]
        phoneNumber in
            self?.output.onTapGet(withPhoneNumber: phoneNumber)
        }
        
        
    }

    func getListFpnVC() -> FPNCountryListViewController {
        phoneView.listController
    }
}

extension PhoneNumberRegistrationViewController: PhoneNumberRegistrationViewInput {
    
    func showWarning(isHidden: Bool) {
        phoneView.numberWasRegisteredLabel.animatedAppearance(isHidden: isHidden)
    }
    func showVerificationField(isHidden: Bool) {
        
        self.phoneView.verificationCodeTextField.animatedAppearance(isHidden: isHidden)
        self.phoneView.yourCodeLabel.animatedAppearance(isHidden: isHidden)
        self.phoneView.isTapped = true
        

    }
    func changeGetButton() {
        self.phoneView.getCodeButton.setTitle("Отправить код еще раз", for: .normal)
        self.phoneView.nextButton.alpha = 0.5
    }
    func GetButtonFlag_getter() -> Bool {
        return self.phoneView.GetButtonTappedOnce
    }
    func GetButtonFlag_setter() {
        self.phoneView.GetButtonTappedOnce = true
    }
    func checkCode() {
        guard let code = self.phoneView.verificationCodeTextField.text else { return }
        
        
        
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: self.phoneView.verificationID, verificationCode: code)
        Auth.auth().signIn(with: credetional) {(_, error) in
            if error != nil {
                /*   let ac =  UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                ac.addAction(cancel)
                self.presentingViewController?.present(ac, animated: true)*/
                self.phoneView.codeIsRight = false
                print("Code is not right")
            } else {
                self.phoneView.codeIsRight = true
                print("Code is right")
            }
        }
    }
    
    func setVerificationID(verificationID: String?) {
        self.phoneView.verificationID = verificationID
    }
    func getCodeStatus() -> Bool {
        print(self.phoneView.codeIsRight)
        return self.phoneView.codeIsRight
    }
    func showVerificationWarning(isHidden: Bool){
        self.phoneView.verificationWasFailed.animatedAppearance(isHidden: isHidden)
    }
}

extension PhoneNumberRegistrationViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {

    }

    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {

            self.phoneView.nextButton.isEnabled = true
            self.phoneView.getCodeButton.alpha = 1
            self.phoneView.getCodeButton.isEnabled = true
            
            self.phoneView.phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            self.phoneView.getCodeButton.alpha = 0.5
            self.phoneView.getCodeButton.isEnabled = false
            self.phoneView.nextButton.isEnabled = false
        }
    }

    func fpnDisplayCountryList() {
        output.onTapFlag()
    }

}

extension PhoneNumberRegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.phoneView.verificationCodeTextField {
            let currentCharacterCount = textField.text?.count ?? 0
            if range.length + range.location > currentCharacterCount {
                return false
            }
            let newLenght = currentCharacterCount + string.count - range.length
            return newLenght <= 6
        } else {
            return true
        }
        
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
    
        if textField == self.phoneView.verificationCodeTextField {
            if textField.text?.count == 6 {
                self.phoneView.nextButton.isEnabled = true
                self.phoneView.nextButton.alpha = 1
                
            } else {
                self.phoneView.nextButton.isEnabled = false
                self.phoneView.nextButton.alpha = 0.5
               
            }
        }
    }
}

