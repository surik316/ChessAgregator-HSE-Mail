//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {

    private let output: AuthViewOutput?

    private var authView: AuthNewView {
        view as! AuthNewView
    }

    private lazy var adapter = KeyboardAdapter(window: view.window) { [weak self] offset, duration in
        self?.keyboardOffsetChanged(offset, duration: duration)
    }

    init(output: AuthViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = AuthNewView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.isNavigationBarHidden = true
        authView.onTapLoginButton = { [weak self] in
            self?.output?.onTapLogin(
                    email: self?.authView.emailTextField.text ?? "",
                    password: self?.authView.passwordTextField.text ?? ""
            )
        }

        authView.onTapSignupButton = { [weak self] in
            self?.output?.onTapSignUp()
        }
        authView.onTapForgotButton = { [weak self] in
            self?.output?.onTapForgot()
        }
        self.authView.emailTextField.addDoneButtonKeyboard()
        self.authView.passwordTextField.addDoneButtonKeyboard()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adapter.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        adapter.stop()
    }
}

extension AuthViewController: AuthViewInput {

}

private extension AuthViewController {
    func keyboardOffsetChanged(_ offset: CGFloat, duration: TimeInterval) {
        let keyboardFrame = view.window!.frame.height - offset
        let authOffset = authView.signupButtonMaxY - keyboardFrame > 0 ? authView.signupButtonMaxY - keyboardFrame : 0
        UIView.animate(withDuration: duration) {
            self.authView.stackViewBottomConstraint?.constant = self.authView.stackViewBottomConstraintConstant - authOffset
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }

}
extension UITextField{
    @IBInspectable var doneAcessory: Bool{
        get{
            return self.doneAcessory
        }
        set (hasDone){
            addDoneButtonKeyboard()
        }
    }
    func addDoneButtonKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
               doneToolbar.barStyle = .default
               
               let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
               let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.doneButtonAction))
               
               let items = [flexSpace, done]
               doneToolbar.items = items
               doneToolbar.sizeToFit()
               
               self.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction()
        {
            self.resignFirstResponder()
        }
}
