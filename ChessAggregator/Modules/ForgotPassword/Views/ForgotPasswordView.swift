//
// Created by Максим Сурков on 07.12.2020.
//

import UIKit
import FlagPhoneNumber


class ForgotPasswordView: AutoLayoutView {

    let scrollableStackView: ScrollableStackView = {
        var result: ScrollableStackView
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 15.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 20.0, left: 16.0, bottom: 0.0, right: -16.0)
        )
        result = ScrollableStackView(config: config)
        return result
    }()

    private let textFieldHeight: CGFloat = 40.0
    private let registrationButtonSpacingToContentView: CGFloat = 20.0
    private let registrationButtonHeight: CGFloat = 50.0
    private let switchToOrganizerStackViewHeight: CGFloat = 30.0
    var registrationOffset: CGFloat {
        registrationButtonSpacingToContentView + registrationButtonHeight + switchToOrganizerStackViewHeight
    }



    private var emailAddressStackView: UIStackView?
    private let emailAddress = UITextField()
    let emailAddressWarning = WarningLabel()




    private let changeButton = UIButton(type: .system)
    var onTapChangeButton: ((String?) -> Void)?

    init() {
        super.init(frame: .zero)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(scrollableStackView)

        setupRoundedTextField(
                textField: emailAddress,
                textFieldPlaceholder: "Введите Ваш email*",
                textFieldKeyboard: .emailAddress
        )
        emailAddressWarning.text = "Адрес почты недействителен. Введите его в формате email@example.com"
        self.emailAddressStackView = buildStackView(withTextField: emailAddress, andLabel: emailAddressWarning)
        self.scrollableStackView.addArrangedSubview(emailAddressStackView!)

        emailAddress.backgroundColor = UIColor.rgba(240, 241, 245)

        
        changeButton.setTitle("Сменить пароль", for: .normal)
        changeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        changeButton.backgroundColor = UIColor.rgba(0, 122, 255)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.layer.cornerRadius = 8.0
        changeButton.clipsToBounds = false
        changeButton.addTarget(self, action: #selector(onTapChange), for: .touchUpInside)

        self.scrollableStackView.addSubview(changeButton)

    }

    override func setupConstraints() {
        super.setupConstraints()

        self.scrollableStackView.pins()


        NSLayoutConstraint.activate([

            changeButton.topAnchor.constraint(
                    equalTo: scrollableStackView.contentView.bottomAnchor,
                    constant: registrationButtonSpacingToContentView
            ),
            changeButton.heightAnchor.constraint(equalToConstant: registrationButtonHeight),
            changeButton.widthAnchor.constraint(equalToConstant: 200.0),
            changeButton.centerXAnchor.constraint(equalTo: scrollableStackView.contentView.centerXAnchor),
        ])

        self.scrollableStackView.set(contentInset: UIEdgeInsets(top: 0, left: 0, bottom: registrationOffset, right: 0))

    }



    @objc private func onTapChange() {
        self.onTapChangeButton?(
                self.emailAddress.text)
    }
}

private extension ForgotPasswordView {

    func buildStackView(withTextField textField: UITextField, andLabel label: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(label)
        return stackView
    }

    func setupRoundedTextField(textField: UITextField, textFieldPlaceholder: String,
                               textFieldKeyboard: UIKeyboardType = .default) {
        let attributedString = buildStringWithColoredAsterisk(string: textFieldPlaceholder)
        textField.attributedPlaceholder = attributedString
        textField.borderStyle = .roundedRect
        textField.keyboardType = textFieldKeyboard
        textField.autocapitalizationType = .none

    }

    func buildStringWithColoredAsterisk(string: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: string)
        let range = (string as NSString).range(of: "*")
        attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: Styles.Color.asteriskRed,
                range: range
        )
        return attributedString
    }
}

