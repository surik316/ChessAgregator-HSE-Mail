//
// Created by Николай Пучко on 08.01.2021.
//

import UIKit

class FooterCloudView: AutoLayoutView {
    var siteTapAction: (() -> Void)?

    private let leftStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    private let rightStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    private let horizontalStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    private let verticalStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center

        return stack
    }()

    private let siteButton: UIButton = {
        var button = UIButton(type: .system)
        let attribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSAttributedString(string: "Положение", attributes: attribute), for: .normal)
        button.backgroundColor = Styles.Color.buttonBlue
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = .zero
        button.layer.shadowColor = Styles.Color.buttonBlue.cgColor
        button.layer.shadowOpacity = 0.7

        button.addTarget(self, action: #selector(onTapSite), for: .touchUpInside)
        return button
    }()

    private let feeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        return label
    }()

    private let underFeeLabel: UILabel = {
        var label = UILabel()
        label.text = "Взнос"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return label
    }()

    private let fundLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        return label
    }()

    private let underFundLabel: UILabel = {
        var label = UILabel()
        label.text = "Призовой фонд"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return label
    }()

    private let toursLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        return label
    }()

    var participantsLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        return label
    }()

    var eloLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        return label
    }()

    private let underEloLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        label.text = "Средний ЭЛО"
        return label
    }()

    private let timeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        return label
    }()

    private let underTimeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return label
    }()

    init(event: Tournament) {
        super.init(frame: .zero)

        feeLabel.text = "\(event.fee) ₽"
        fundLabel.text = "\(event.prizeFund) ₽"
        toursLabel.text = "⚔ \(event.tours)"
        participantsLabel.text = "👤 \(event.participantsCount)"
        eloLabel.text = "\(0)"

        timeLabel.text = "\(Int(event.minutes + event.seconds/60)) ＋ '\(event.increment)"
        underTimeLabel.text = event.mode.rawValue

        setupStack()

        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 18
        layer.shadowOpacity = 1
        layer.shadowRadius = 7
        layer.shadowOffset = .zero
        layer.shadowColor = layer.borderColor
    }

    override func setupConstraints() {
        super.setupConstraints()
        verticalStack.pins()

        NSLayoutConstraint.activate([
            siteButton.widthAnchor.constraint(equalToConstant: 120),
            siteButton.heightAnchor.constraint(equalToConstant: 30),

            horizontalStack.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),

            participantsLabel.heightAnchor.constraint(equalToConstant: 24),
            participantsLabel.heightAnchor.constraint(equalTo: toursLabel.heightAnchor),
            feeLabel.heightAnchor.constraint(equalToConstant: 18),
            feeLabel.heightAnchor.constraint(equalTo: eloLabel.heightAnchor),
            underFeeLabel.heightAnchor.constraint(equalToConstant: 12),
            underFeeLabel.heightAnchor.constraint(equalTo: underEloLabel.heightAnchor),
            fundLabel.heightAnchor.constraint(equalToConstant: 18),
            fundLabel.heightAnchor.constraint(equalTo: timeLabel.heightAnchor),
            underFundLabel.heightAnchor.constraint(equalToConstant: 18),
            underFundLabel.heightAnchor.constraint(equalTo: underEloLabel.heightAnchor)

        ])

    }

    private func setupStack() {
        leftStack.addArrangedSubview(participantsLabel)
        leftStack.addArrangedSubview(feeLabel)
        leftStack.addArrangedSubview(underFeeLabel)
        leftStack.addArrangedSubview(fundLabel)
        leftStack.addArrangedSubview(underFundLabel)

        leftStack.setCustomSpacing(16, after: participantsLabel)
        leftStack.setCustomSpacing(2, after: feeLabel)
        leftStack.setCustomSpacing(16, after: underFeeLabel)
        leftStack.setCustomSpacing(2, after: fundLabel)

        rightStack.addArrangedSubview(toursLabel)
        rightStack.addArrangedSubview(eloLabel)
        rightStack.addArrangedSubview(underEloLabel)
        rightStack.addArrangedSubview(timeLabel)
        rightStack.addArrangedSubview(underTimeLabel)

        rightStack.setCustomSpacing(16, after: toursLabel)
        rightStack.setCustomSpacing(2, after: eloLabel)
        rightStack.setCustomSpacing(16, after: underEloLabel)
        rightStack.setCustomSpacing(2, after: timeLabel)

        horizontalStack.addArrangedSubview(leftStack)
        horizontalStack.addArrangedSubview(rightStack)

        verticalStack.addArrangedSubview(siteButton)
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        verticalStack.setCustomSpacing(16, after: siteButton)

        addSubview(verticalStack)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @objc
    private func onTapSite() {
        siteTapAction?()
    }
}
