//
// Created by Administrator on 05.11.2020.
//

import UIKit

class AuthNewView: AutoLayoutView {
    
    private lazy var stackView = UIStackView()
    var email: String = "email@example.com"

    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    private let loginButton = UIButton(type: .system)
    private let signupButton = UIButton(type: .system)
    private let forgotButton = UIButton(type: .system)
    private let label = UILabel()
    private let textNewUser = UILabel()
    
    var onTapLoginButton: (() -> Void)?
    var onTapSignupButton: (() -> Void)?
    var onTapForgotButton: (() -> Void)?

    var stackViewBottomConstraint: NSLayoutConstraint?
    var stackViewBottomConstraintConstant: CGFloat { -bounds.height/2.0 }
    lazy var signupButtonMaxY: CGFloat = signupButton.frame.maxY

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setup() {
        
        backgroundColor = .white

        stackView.axis = .vertical

        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) as Any])
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.addTarget(self, action: #selector(editPassword), for: .editingDidEndOnExit)
        emailTextField.backgroundColor = UIColor.rgba(240, 241, 245)

        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) as Any])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.backgroundColor = UIColor.rgba(240, 241, 245)

        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.setCustomSpacing(11.0, after: emailTextField)
        
        
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = UIColor.rgba(0, 122, 255)
        loginButton.setTitleColor(.white, for: .normal)

        loginButton.layer.cornerRadius = 8
        loginButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        loginButton.clipsToBounds = false

        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)

        forgotButton.setTitle("Забыли пароль?", for: .normal)
        forgotButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        forgotButton.addTarget(self, action: #selector(onTapForgot), for: .touchUpInside)


        signupButton.setTitle("Зарегистрироваться", for: .normal)
        signupButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        signupButton.addTarget(self, action: #selector(onTapSignup), for: .touchUpInside)

        

        addSubview(label)
        addSubview(stackView)
        addSubview(loginButton)
        addSubview(forgotButton)
        addSubview(textNewUser)
        addSubview(signupButton)
        
        
        textNewUser.text = "У вас нет аккаунта?"
        textNewUser.textAlignment = .center
        textNewUser.textColor = .black
        textNewUser.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
        label.horizontal()
        label.text = "Авторизация"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
    }


    override func setupConstraints() {
        super.setupConstraints()

        let margins = safeAreaLayoutGuide
//        stackViewBottomConstraint = stackView.bottomAnchor.constraint(
//                equalTo: margins.bottomAnchor,
//                constant: -bounds.height/2.0
//        )
        [
            label.topAnchor.constraint(equalTo: margins.topAnchor,constant: bounds.height/11),

            emailTextField.heightAnchor.constraint(equalToConstant: 53.0),

            passwordTextField.heightAnchor.constraint(equalToConstant: 53.0),
            
            //stackViewBottomConstraint!,
            
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor,constant: 16.0),
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: bounds.height/11),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16.0),


            loginButton.heightAnchor.constraint(equalToConstant: 68),
            loginButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20.0),
            loginButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20.0),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 51.0),

            loginButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            forgotButton.heightAnchor.constraint(equalToConstant: 40.0),
            forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10.0),
            forgotButton.widthAnchor.constraint(equalToConstant: bounds.width/2),
            forgotButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            textNewUser.leftAnchor.constraint(equalTo: loginButton.leftAnchor),
            textNewUser.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            signupButton.heightAnchor.constraint(equalToConstant: 22),
            signupButton.topAnchor.constraint(equalTo: textNewUser.topAnchor),
            signupButton.rightAnchor.constraint(equalTo: loginButton.rightAnchor),
        
        ].forEach {$0.isActive = true}

    }

    @objc
    private func onTapLogin() {
        email = emailTextField.text ?? "email@example.com"
        onTapLoginButton?()
    }

    @objc
    private func onTapSignup() -> Void {
        onTapSignupButton?()
    }

    @objc
    private func onTapForgot() -> Void {
        onTapForgotButton?()
    }

    @objc
    private func editPassword() {
        if passwordTextField.text == "" {
            passwordTextField.becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
    }
}
