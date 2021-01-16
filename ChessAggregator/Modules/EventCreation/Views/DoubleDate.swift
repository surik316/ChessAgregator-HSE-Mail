//
// Created by Administrator on 06.12.2020.
//

import UIKit

class DoubleDate: AutoLayoutView {
    let openDate : UIDatePicker = {
        var date = UIDatePicker()
        date.minimumDate = Date()
        date.locale = Locale(identifier: "ru_RU") // TODO: .current
        date.datePickerMode = .date
        date.preferredDatePickerStyle = .compact
        return date
    }()

    let closeDate: UIDatePicker = {
        var date = UIDatePicker()
        date.minimumDate = Date()
        date.locale = Locale(identifier: "ru_RU") // TODO: .current
        date.datePickerMode = .date
        date.preferredDatePickerStyle = .compact
        return date
    }()

    private let openLabel: UILabel = {
        var label = UILabel()
        label.text = "Открытие"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    private let closeLabel: UILabel = {
        var label = UILabel()
        label.text = "Закрытие"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    init() {
        super.init(frame: .zero)


        [openDate, closeDate, openLabel, closeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        setupConstraints()
        openDate.addTarget(self, action: #selector(didChangedOpenDate), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func didChangedOpenDate() {
        closeDate.setDate(openDate.date, animated: true)
        closeDate.minimumDate = openDate.date
    }



    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),

            openDate.topAnchor.constraint(equalTo: topAnchor),
            openDate.leadingAnchor.constraint(equalTo: leadingAnchor),
            openDate.heightAnchor.constraint(equalToConstant: 40),

            closeDate.topAnchor.constraint(equalTo: openDate.topAnchor),
            closeDate.trailingAnchor.constraint(equalTo: trailingAnchor),
            closeDate.heightAnchor.constraint(equalTo: openDate.heightAnchor),

            openLabel.topAnchor.constraint(equalTo: openDate.bottomAnchor),
            openLabel.heightAnchor.constraint(equalToConstant: openLabel.font.pointSize),
            openLabel.leadingAnchor.constraint(equalTo: openDate.leadingAnchor),
            openLabel.widthAnchor.constraint(equalTo: openDate.widthAnchor),

            closeLabel.topAnchor.constraint(equalTo: openLabel.topAnchor),
            closeLabel.heightAnchor.constraint(equalTo: openLabel.heightAnchor),
            closeLabel.trailingAnchor.constraint(equalTo: closeDate.trailingAnchor),
            closeLabel.widthAnchor.constraint(equalTo: closeDate.widthAnchor)
        ])
    }
}
