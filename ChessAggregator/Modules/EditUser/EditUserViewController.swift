//
//  EditUserViewController.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import UIKit

final class EditUserViewController: UIViewController {
	private let output: EditUserViewOutput
    private let stackView = ScrollableStackView(config: .defaultVertical)
    private let lastNameTextField = MaterialTextField()
    lazy private var lastNameField = MaterialStack(name: "Фамилия", field: lastNameTextField)
    private let firstNameTextField = MaterialTextField()
    lazy private var firstNameField = MaterialStack(name: "Имя", field: firstNameTextField)
    private let patronymicNameTextField = MaterialTextField()
    lazy private var patronymicNameField = MaterialStack(name: "Отчество", field: patronymicNameTextField)

    private let genderTextField = PickableTextField()
    lazy private var genderField = MaterialStack(name: "Пол", field: genderTextField)
    private let genderPicker = UIPickerView()
    private let frcTextField = MaterialTextField()
    lazy private var frcField = MaterialStack(name: "ФШР ID", field: frcTextField)
    private let fideTextField = MaterialTextField()
    lazy private var fideField = MaterialStack(name: "FIDE ID", field: fideTextField)


    init(output: EditUserViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.scrollView.delegate = self
        navigationController?.isNavigationBarHidden = false

        view.addSubview(stackView)
        stackView.scrollView.delegate = self
        stackView.pins()
        stackView.config.stack.spacing = 4
        stackView.config.pinsStackConstraints.top = 8
        stackView.config.pinsStackConstraints.left = 4
        stackView.config.pinsStackConstraints.right = -4
        view.backgroundColor = .white
        setupFields()

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.isEnabled = false


    }

    private func setupFields() {
        let user = output.userState()
        lastNameTextField.placeholder = user.player.lastName
        lastNameTextField.text = user.player.lastName
        firstNameTextField.placeholder = user.player.firstName
        firstNameTextField.text = user.player.firstName
        patronymicNameTextField.placeholder = user.player.patronomicName
        patronymicNameTextField.text = user.player.patronomicName
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignAll))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spacer, closeButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        genderTextField.inputView = genderPicker
        genderTextField.inputAccessoryView = toolbar
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        genderTextField.text = user.player.sex.rawValue
        genderTextField.placeholder = user.player.sex.rawValue
        if user.player.sex == .male {
            genderPicker.selectRow(0, inComponent: 0, animated: false)
        } else {
            genderPicker.selectRow(1, inComponent: 0, animated: false)
        }
        
        if let id = user.player.frcID {
            frcTextField.text = String(id)
            frcTextField.placeholder = String(id)
        }
        frcTextField.keyboardType = .numberPad

        if let id = user.player.fideID {
            fideTextField.text = String(id)
            fideTextField.placeholder = String(id)
        }
        fideTextField.keyboardType = .numberPad
        

        stackView.addArrangedSubview(lastNameField)
        stackView.addArrangedSubview(firstNameField)
        stackView.addArrangedSubview(patronymicNameField)
        stackView.addArrangedSubview(genderField)
        stackView.addArrangedSubview(frcField)
        stackView.addArrangedSubview(fideField)
        
        lastNameTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
        firstNameTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
        patronymicNameTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
        genderTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
        frcTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
        fideTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
    }

    @objc
    private func endCreation() {
        output.close()
    }
    
    @objc
    private func highlight() {
        let user = output.userState()
        if lastNameTextField.text != user.player.lastName ||
            firstNameTextField.text != user.player.firstName ||
            patronymicNameTextField.text != user.player.patronomicName ||
            genderTextField.text != user.player.sex.rawValue {
            navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            navigationItem.rightBarButtonItem?.isEnabled = true
            return
        }

        
        if let idFromField = frcTextField.text {
            if let id = Int(idFromField) {
                if id != user.player.frcID {
                    navigationItem.rightBarButtonItem?.tintColor = .systemBlue
                    navigationItem.rightBarButtonItem?.isEnabled = true
                    return
                }
            }
        } else {
            if user.player.frcID != nil {
                navigationItem.rightBarButtonItem?.tintColor = .systemBlue
                navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
        }

        if let idFromField = fideTextField.text {
            if let id = Int(idFromField) {
                if id != user.player.fideID {
                    navigationItem.rightBarButtonItem?.tintColor = .systemBlue
                    navigationItem.rightBarButtonItem?.isEnabled = true
                    return
                }
            }
        } else {
            if user.player.fideID != nil {
                navigationItem.rightBarButtonItem?.tintColor = .systemBlue
                navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
        }

        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    @objc
    private func save() {
        var user = output.userState()
        // TODO: add check for empty (but not nil) textFields
        user.player.firstName = firstNameTextField.text ?? user.player.firstName
        user.player.lastName = lastNameTextField.text ?? user.player.lastName
        user.player.patronomicName = patronymicNameTextField.text
        user.player.sex = Sex(rawValue: genderTextField.text ?? "") ?? user.player.sex
        if let ID = frcTextField.text {
            if let exactID = Int(ID) {
                user.player.frcID = Int(exactID)
            }
        }
        if let ID = fideTextField.text {
            if let exactID = Int(ID) {
                user.player.fideID = Int(exactID)
            }
        }

        
        output.editUser(with: user)
    }
    
    @objc
    private func resignAll() {
        view.endEditing(true)
    }
}

extension EditUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == genderPicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker {
            return 2 // male/female
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPicker {
            if row == 0 {
                return Sex.male.rawValue
            } else {
                return Sex.female.rawValue
            }
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
            if row == 0 {
                genderTextField.text = Sex.male.rawValue
            } else {
                genderTextField.text = Sex.female.rawValue
            }
        }
    }
}

extension EditUserViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension EditUserViewController: EditUserViewInput {
}
