//
// Created by Иван Лизогуб on 15.11.2020.
//

import Foundation
import UIKit

class UserRegistrationPlayerView: AutoLayoutView {
    let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 20.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 20.0, left: 16.0, bottom: 0.0, right: -16.0)
        )
        return ScrollableStackView(config: config)
    }()

    private let textFieldHeight: CGFloat = 40.0
    private let registrationButtonSpacingToContentView: CGFloat = 20.0
    private let registrationButtonHeight: CGFloat = 66.0
    private let switchToOrganizerStackViewHeight: CGFloat = 30.0
    let maxValueOfId = 999999999
    var registrationOffset: CGFloat {
        registrationButtonSpacingToContentView + registrationButtonHeight + switchToOrganizerStackViewHeight
    }


    private lazy var lastNameStackView = buildStackView(withTextField: lastName, andLabel: lastNameWarning)
    let lastName = MaterialTextField()
    let lastNameWarning = WarningLabel()

    private lazy var firstNameStackView = buildStackView(withTextField: firstName, andLabel: firstNameWarning)
    let firstName = MaterialTextField()
    let firstNameWarning = WarningLabel()

    lazy var sex = UISegmentedControl(items: sexList)
    var sexStackView = UIStackView()
    var sexLabel = UILabel()
    var sexList: [String] = Sex.allCases.map{ $0.rawValue }

    let patronymicName = MaterialTextField()

    let latinFullname = MaterialTextField()
    private let fullnameButton = UIButton(type: .infoLight)
    var onTapLatinFullnameButton: (()->Void)?
    
    let fideID = MaterialTextField()
    private let fideIDButton = UIButton(type: .infoLight)
    var onTapFideButton: (() -> Void)?

    let frcID = MaterialTextField()
    private let frcIDButton = UIButton(type: .infoLight)
    var onTapFrcButton: (() -> Void)?

    private lazy var emailAddressStackView = buildStackView(withTextField: emailAddress, andLabel: emailAddressWarning)
    let emailAddress = MaterialTextField()
    let emailAddressWarning = WarningLabel()
    let emailWasRegisteredWarning = WarningLabel()

    private lazy var passwordStackView = buildStackView(withTextField: password, andLabel: passwordWarning)
    let password = MaterialTextField()
    let passwordWarning = WarningLabel()

    private lazy var validatePasswordStackView = buildStackView(withTextField: validatePassword, andLabel: validatePasswordWarning)
    let validatePassword = MaterialTextField()
    let validatePasswordWarning = WarningLabel()

    private let birthdateStackView = UIStackView()
    private let birthdateLabel = UILabel()
    private let birthdateDatePicker = UIDatePicker()

    private let switchToOrganizerStackView = UIStackView()
    private let switchToOrganizer = UISwitch()
    private let switchToOrganizerLabel = UILabel()

    let organizationCity = MaterialTextField()

    private let organizationNameStackView = UIStackView()
    let organizationName = MaterialTextField()
    let organizationNameWarning = WarningLabel()
    
    private let registrationButton = UIButton(type: .system)
    var onTapRegistrationButton: ((String?, String?, String?, String?, String?, String?,
                                   String?, String?, Bool, String?, String?, Date, String?, String?) -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(scrollableStackView)

        setupRoundedTextField(textField: lastName, textFieldPlaceholder: "Фамилия*")

        self.lastNameWarning.text = "Пустое поле. Введите свою фамилию"
        self.scrollableStackView.addArrangedSubview(lastNameStackView)


        setupRoundedTextField(textField: firstName, textFieldPlaceholder: "Имя*")
        firstNameWarning.text = "Пустое поле. Введите свое имя"
        scrollableStackView.addArrangedSubview(firstNameStackView)

        setupRoundedTextField(textField: patronymicName, textFieldPlaceholder: "Отчество")
        scrollableStackView.addArrangedSubview(patronymicName)
        
        self.sex.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) as Any ,NSAttributedString.Key.foregroundColor: UIColor.gray as Any], for: .normal)
        self.sex.selectedSegmentIndex = 0
        
        self.sexLabel.textColor = UIColor.rgba(142, 142, 147)
        self.sexLabel.attributedText = buildStringWithColoredAsterisk(string: "Пол*")
        self.sexLabel.textAlignment = .center
        self.sexLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)

        
        self.sexStackView.addArrangedSubview(sexLabel)
        self.sexStackView.addArrangedSubview(sex)
        self.sexStackView.spacing = 16
        self.scrollableStackView.addArrangedSubview(sexStackView)

        self.birthdateLabel.textColor = UIColor.rgba(142, 142, 147)
        self.birthdateLabel.attributedText = buildStringWithColoredAsterisk(string: "Дата рождения*")
        self.birthdateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        

        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.year = -150
        let minDate = calendar.date(byAdding: components, to: Date())
        let maxDate = Date()
        self.birthdateDatePicker.datePickerMode = .date
        self.birthdateDatePicker.maximumDate = maxDate
        self.birthdateDatePicker.minimumDate = minDate
        self.birthdateDatePicker.locale = Locale(identifier: "ru_RU")
        
        self.birthdateStackView.addArrangedSubview(birthdateLabel)
        self.birthdateStackView.addArrangedSubview(birthdateDatePicker)

        self.scrollableStackView.addArrangedSubview(birthdateStackView)
        setupRoundedTextField(
                textField: emailAddress,
                textFieldPlaceholder: "Введите Ваш email*",
                textFieldKeyboard: .emailAddress
        )
        emailAddressWarning.text = "Адрес почты недействителен. Введите его в формате email@example.com"
        emailAddressStackView.addArrangedSubview(emailWasRegisteredWarning)
        scrollableStackView.addArrangedSubview(emailAddressStackView)

        setupRoundedTextField(textField: fideID, textFieldPlaceholder: "FideID", textFieldKeyboard: .numberPad)
        fideID.rightView = fideIDButton
        fideID.rightViewMode = .always
        fideIDButton.addTarget(self, action: #selector(onTapFide), for: .touchUpInside)
        scrollableStackView.addArrangedSubview(fideID)

        setupRoundedTextField(textField: frcID, textFieldPlaceholder: "ФШР ID", textFieldKeyboard: .numberPad)
        frcID.rightView = frcIDButton
        frcID.rightViewMode = .always
        frcIDButton.addTarget(self, action: #selector(onTapFrc), for: .touchUpInside)
        
        scrollableStackView.addArrangedSubview(frcID)
        
        setupRoundedTextField(textField: latinFullname, textFieldPlaceholder: "Фамилия и имя (Латиница)", textFieldKeyboard: .default)
        latinFullname.rightView = fullnameButton
        latinFullname.rightViewMode = .always
        fullnameButton.addTarget(self, action: #selector(onTapLatinFullname), for: .touchUpInside)
        latinFullname.addTarget(self, action: #selector(textFieldFullnameChanged), for: .editingChanged)
        scrollableStackView.addArrangedSubview(latinFullname)

        
        setupRoundedTextField(textField: password, textFieldPlaceholder: "Пароль*")
        password.isSecureTextEntry = true
        passwordWarning.text = "Пароль недействителен. Он должен содержать 1 Большую букву, 1 маленькую и 1 цифру"
        scrollableStackView.addArrangedSubview(passwordStackView)

        setupRoundedTextField(textField: validatePassword, textFieldPlaceholder: "Подтверждение пароля*")
        validatePassword.isSecureTextEntry = true
        validatePasswordWarning.text = "Пароли не совпадают."
        scrollableStackView.addArrangedSubview(validatePasswordStackView)


        self.registrationButton.setTitle("Зарегистрироваться", for: .normal)
        self.registrationButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        self.registrationButton.backgroundColor = UIColor.rgba(0, 122, 255)
        self.registrationButton.setTitleColor(.white, for: .normal)
        self.registrationButton.layer.cornerRadius = 15.0
        self.registrationButton.clipsToBounds = false
        self.registrationButton.addTarget(self, action: #selector(onTapRegistration), for: .touchUpInside)


        scrollableStackView.addSubview(registrationButton)

        switchToOrganizerStackView.axis = .horizontal
        switchToOrganizerStackView.distribution = .equalSpacing
        switchToOrganizerStackView.alignment = .fill

        switchToOrganizerLabel.text = "Вы организатор?"

        switchToOrganizerStackView.addArrangedSubview(switchToOrganizerLabel)
        switchToOrganizerStackView.addArrangedSubview(switchToOrganizer)

        scrollableStackView.addSubview(switchToOrganizerStackView)

        setupRoundedTextField(textField: organizationCity, textFieldPlaceholder: "Город")
        organizationCity.isHidden = true
        scrollableStackView.addArrangedSubview(organizationCity)

        organizationNameStackView.axis = .vertical
        organizationNameStackView.distribution = .fill
        organizationNameStackView.alignment = .fill
        setupRoundedTextField(textField: organizationName, textFieldPlaceholder: "Название организации*")
        organizationNameWarning.text = "Поле названия организации пустое. Пожалуйста, заполните его"
        organizationNameStackView.addArrangedSubview(organizationName)
        organizationNameStackView.addArrangedSubview(organizationNameWarning)
        organizationName.isHidden = true
        scrollableStackView.addArrangedSubview(organizationNameStackView)

        switchToOrganizer.addTarget(self, action: #selector(onTapSwitchToOrganizer), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()

        scrollableStackView.pins()

        let margins = layoutMarginsGuide

        NSLayoutConstraint.activate([
            switchToOrganizerStackView.heightAnchor.constraint(equalToConstant: switchToOrganizerStackViewHeight),
            switchToOrganizerStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            switchToOrganizerStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            switchToOrganizerStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            
            registrationButton.topAnchor.constraint(
                    equalTo: scrollableStackView.contentView.bottomAnchor,
                    constant: registrationButtonSpacingToContentView
            ),
            
            sex.widthAnchor.constraint(equalToConstant: 267),
            sexStackView.heightAnchor.constraint(equalToConstant: 44),
            
            //birthdateLabel.leadingAnchor.constraint(equalTo: sexLabel.leftAnchor, constant: 20),
            birthdateDatePicker.widthAnchor.constraint(equalToConstant: 166),
            birthdateDatePicker.heightAnchor.constraint(equalToConstant: 44),
            birthdateStackView.heightAnchor.constraint(equalToConstant: 44),

            registrationButton.heightAnchor.constraint(equalToConstant: registrationButtonHeight), //283
            registrationButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 46),
            registrationButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -46),
            registrationButton.centerXAnchor.constraint(equalTo: scrollableStackView.contentView.centerXAnchor),
        ])

        scrollableStackView.set(contentInset: UIEdgeInsets(top: 0, left: 0, bottom: registrationOffset, right: 0))

    }


    @objc private func onTapSwitchToOrganizer() {
        scrollableStackView.set(contentInset:
        UIEdgeInsets(top: 0.0, left: 0, bottom: registrationOffset, right: 0)
        )
        UIView.animate(withDuration: 0.5, delay:0.0, options: [],
                animations: {
                    self.organizationName.isHidden = !self.switchToOrganizer.isOn
                    self.organizationCity.isHidden = !self.switchToOrganizer.isOn
                    self.organizationNameWarning.isHidden = true
                    self.layoutIfNeeded()
                },
                completion: nil
        )
    }

    @objc private func onTapRegistration() {

        onTapRegistrationButton?(
                lastName.text, firstName.text, patronymicName.text, fideID.text,
                frcID.text, emailAddress.text, password.text, validatePassword.text,
                switchToOrganizer.isOn, organizationCity.text, organizationName.text,
                birthdateDatePicker.date, sex.titleForSegment(at: sex.selectedSegmentIndex),
                latinFullname.text)
    }

    @objc private func onTapFide() {
        onTapFideButton?()
    }

    @objc private func onTapFrc() {
        onTapFrcButton?()
    }

    @objc private func onTapLatinFullname() {
        onTapLatinFullnameButton?()
    }
    @objc private func textFieldFullnameChanged(){

        if latinFullname.text != ""  {
            fideID.isEnabled = false
            fideID.alpha = 0.5
            
            frcID.isEnabled = false
            frcID.alpha = 0.5
        } else {
            fideID.alpha = 1
            fideID.isEnabled = true
            
            frcID.alpha = 1
            frcID.isEnabled = true
        }
    }
}

private extension UserRegistrationPlayerView {

    func buildStackView(withTextField textField: UITextField, andLabel label: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(label)
        return stackView
    }

    func setupRoundedTextField(textField: MaterialTextField, textFieldPlaceholder: String,
                                       textFieldKeyboard: UIKeyboardType = .default) {
        
        let attribudetString = buildStringWithColoredAsterisk(string: textFieldPlaceholder)
        
        textField.attributedPlaceholder = attribudetString
        textField.backgroundColor = UIColor.rgba(240, 241, 245)
        textField.layer.cornerRadius = 8
        textField.keyboardType = textFieldKeyboard
        textField.autocapitalizationType = .none

        textField.sizeToFit()
        
    }

    func buildStringWithColoredAsterisk(string: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: string)
        let range = (string as NSString).range(of: "*")
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIColor.rgba(0, 122, 255), range: NSRange(location: 0, length: attributedString.length))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 20 ) as Any, range: NSRange(location: 0, length: attributedString.length))
        
        attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: Styles.Color.asteriskRed,
                range: range
        )
        
            
       
        return attributedString
    }

}
