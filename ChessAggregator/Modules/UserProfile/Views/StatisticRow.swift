//
// Created by Иван Лизогуб on 10.01.2021.
//

import UIKit

class StatisticRow: AutoLayoutView {
    let mainView = UIView()
    let label = UILabel()
    let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
    let statisticsImage = UIImageView()

    init(name: String, image: UIImage) {
        super.init(frame: .zero)

        label.text = name
        statisticsImage.image = image
        statisticsImage.contentMode = .scaleAspectFit
        setup()
    }

    private func setup() {

        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        statisticsImage.translatesAutoresizingMaskIntoConstraints = false

        arrow.tintColor = .black
        mainView.addSubview(statisticsImage)
        mainView.addSubview(label)
        mainView.addSubview(arrow)

    }

    private var didSetupConstraints: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupConstraints() {
        super.setupConstraints()

        addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalTo: superview!.heightAnchor),
            mainView.widthAnchor.constraint(equalTo: superview!.widthAnchor, constant: -8),
            mainView.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: superview!.centerYAnchor),

            statisticsImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),
            statisticsImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            statisticsImage.widthAnchor.constraint(equalToConstant: 50.0),
            statisticsImage.heightAnchor.constraint(equalToConstant: 50.0),

            label.leadingAnchor.constraint(equalTo: statisticsImage.trailingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

            arrow.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            arrow.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            arrow.widthAnchor.constraint(equalToConstant: 18.0),
            arrow.heightAnchor.constraint(equalToConstant: 23.0)
        ])
    }
}
