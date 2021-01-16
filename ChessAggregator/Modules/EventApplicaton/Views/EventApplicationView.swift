//
// Created by Иван Лизогуб on 28.12.2020.
//

import UIKit

class EventApplicationView: AutoLayoutView {

    private let previewStack = ScrollableStackView(config: .defaultVertical)
    private let applyButton = UIButton(type: .system)
    private let headerCloud: HeaderCloudView
    let footerCloud: FooterCloudView
    let startList: StableTableView // TODO: add shadow and corner radius

    var onTapApplicationButton: (() -> Void)?

    init(event: Tournament, onTapSite: (() -> Void)?) {
        headerCloud = HeaderCloudView(event: event)
        footerCloud = FooterCloudView(event: event)
        footerCloud.siteTapAction = onTapSite
        startList = StableTableView(frame: .zero, style: .plain)
        super.init(frame: .zero)
        backgroundColor = .white
        setupList()
        setupButton()
        setupStack()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("not supported")
    }

    private func setupList() {
        startList.isScrollEnabled = false
        startList.backgroundColor = .white
        startList.allowsSelection = false
//        startList.rowHeight = UITableView.automaticDimension
//        startList.estimatedRowHeight = 60
    }

    private func setupStack() {
        let topPadding = UIView()
        topPadding.heightAnchor.constraint(equalToConstant: 8).isActive = true

        previewStack.addArrangedSubview(topPadding)
        previewStack.addArrangedSubview(headerCloud)
        previewStack.addArrangedSubview(footerCloud)
        previewStack.addArrangedSubview(applyButton)
        previewStack.addArrangedSubview(startList)

        previewStack.config.stack.distribution = .fillProportionally
        previewStack.config.stack.alignment = .center
        previewStack.config.stack.spacing = 24

        addSubview(previewStack)
    }

    private func setupButton() {
        let applyAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        applyButton.setAttributedTitle(NSAttributedString(string: "Подать заявку", attributes: applyAttribute), for: .normal)
        applyButton.backgroundColor = Styles.Color.buttonBlue
        applyButton.layer.cornerRadius = 15
        applyButton.layer.shadowRadius = 7
        applyButton.layer.shadowOffset = .zero
        applyButton.layer.shadowColor = Styles.Color.buttonBlue.cgColor
        applyButton.layer.shadowOpacity = 1

        applyButton.addTarget(self, action: #selector(onTapApplication), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            headerCloud.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerCloud.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            footerCloud.leadingAnchor.constraint(equalTo: headerCloud.leadingAnchor),
            footerCloud.trailingAnchor.constraint(equalTo: headerCloud.trailingAnchor),

            applyButton.heightAnchor.constraint(equalToConstant: 50),
            applyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            startList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            startList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            previewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewStack.topAnchor.constraint(equalTo: topAnchor),
            previewStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }

    @objc private func onTapApplication() {
        onTapApplicationButton?()
    }
}
