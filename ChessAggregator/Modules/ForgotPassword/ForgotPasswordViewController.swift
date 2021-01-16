//
//  ForgotPasswordViewController.swift
//  ChessAggregator
//
//  Created by Гарик  on 06.12.2020.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    let output: ForgotPasswordViewOutput

    private let registrationView = ForgotPasswordView()

    private lazy var adapter = KeyboardAdapter(window: self.view.window) { [weak self] offset, duration in
        self?.keyboardOffsetChanged(offset, duration: duration)
    }

    init(output: ForgotPasswordViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboard")
    }

    override func loadView() {
        self.view = registrationView
        self.view.backgroundColor = .white
        self.setup()
    }

    private func setup() {
        title = "Восстановление пароля"
        registrationView.onTapChangeButton = { [weak self]
        emailAddress in

            self?.output.onTapChange(
                    email: emailAddress
            )

        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Назад",
                style: .done,
                target: self,
                action: #selector(backButtonTapped))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adapter.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        adapter.stop()
    }

    @objc
    private func backButtonTapped() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.popToRootViewController(animated: true)
    }

}

extension ForgotPasswordViewController: ForgotPasswordViewInput {



    func showEmailWarning(isHidden: Bool) {
        registrationView.emailAddressWarning.animatedAppearance(isHidden: isHidden)
    }

}

extension ForgotPasswordViewController: UITextFieldDelegate {

}


private extension ForgotPasswordViewController {
    func keyboardOffsetChanged(_ offset: CGFloat, duration: TimeInterval) {
        let contentInsets = UIEdgeInsets(
                top: 0.0, left: 0.0,
                bottom: offset + registrationView.registrationOffset, right: 0.0
        )
        registrationView.scrollableStackView.set(contentInset: contentInsets)
    }

    func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tap)
    }

    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}
