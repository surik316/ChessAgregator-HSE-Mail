//
// Created by Николай Пучко on 10.01.2021.
//

import UIKit

class EventCardView : AutoLayoutView {

    private let teamImage: UIImageView
    private let timeImage: UIImageView
    private let ratingImage: UIImageView
    private let locationImage: UIImageView
    private let dateImage: UIImageView

    private let nameLabel: UILabel
    private let timeLabel: UILabel
    private let ratingLabel: UILabel
    private let locationLabel: UILabel
    private let dateLabel: UILabel

    override init(frame: CGRect) {
        teamImage = UIImageView(image: UIImage(systemName: "checkerboard.rectangle")!) // replace with event admin picture
        teamImage.layer.cornerRadius = 30
        teamImage.clipsToBounds = true
        teamImage.layer.borderWidth = 1
        teamImage.layer.borderColor = UIColor.gray.cgColor

        timeImage = UIImageView(image: UIImage(systemName: "clock")!)
        timeImage.tintColor = .black
        locationImage = UIImageView(image: UIImage(systemName: "location")!)
        locationImage.tintColor = .black
        ratingImage = UIImageView(image: UIImage(systemName: "star")!) // chart.bar - alternative
        ratingImage.tintColor = .black
        dateImage = UIImageView(image: UIImage(systemName: "calendar")!)
        dateImage.tintColor = .black

        nameLabel = UILabel()
        nameLabel.text = "Название турнира"
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        nameLabel.numberOfLines = 0

        timeLabel = UILabel()
        timeLabel.text = "Контроль"
        timeLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)

        locationLabel = UILabel()
        locationLabel.text = "Место проведения"
        locationLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)

        ratingLabel = UILabel()
        ratingLabel.text = "0"
        ratingLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)

        dateLabel = UILabel()
        dateLabel.text = ""
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)

        super.init(frame: frame)

        let nameStack = UIStackView(arrangedSubviews: [teamImage, nameLabel])
        nameStack.axis = .horizontal
        nameStack.spacing = 4
        nameStack.alignment = .center
        nameStack.distribution = .fillProportionally

        let timeStack = UIStackView(arrangedSubviews: [timeImage, timeLabel])
        timeStack.axis = .horizontal
        timeStack.spacing = 4
        timeStack.alignment = .center

        let locationStack = UIStackView(arrangedSubviews: [locationImage, locationLabel])
        locationStack.axis = .horizontal
        locationStack.spacing = 4
        locationStack.alignment = .center

        let ratingStack = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        ratingStack.alignment = .center

        let dateStack = UIStackView(arrangedSubviews: [dateImage, dateLabel])
        dateStack.axis = .horizontal
        dateStack.spacing = 4
        dateStack.alignment = .center

        let verticalStack = UIStackView(arrangedSubviews: [
            nameStack,
            timeStack,
            ratingStack,
            locationStack,
            dateStack
        ])

        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill
        verticalStack.setCustomSpacing(8, after: nameStack)
        verticalStack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        addSubview(verticalStack)
        verticalStack.pins()

        // may improve performance
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale

        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 18
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = .zero
        layer.shadowColor = layer.borderColor
    }

    convenience init(event: Tournament) {
        self.init()
        nameLabel.text = event.name
        timeLabel.text = event.mode.rawValue
        ratingLabel.text = event.ratingType.rawValue
        locationLabel.text = event.location
        dateLabel.text = "\(event.openDate) - \(event.closeDate)"
    }

    override func setupConstraints() {
        super.setupConstraints()

        [teamImage, timeImage, locationImage, ratingImage, dateImage,
         nameLabel, timeLabel, locationLabel, ratingLabel, dateLabel].forEach {
            view in view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            teamImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            teamImage.heightAnchor.constraint(equalToConstant: 60),
            teamImage.widthAnchor.constraint(equalToConstant: 60),

            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: teamImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            locationImage.heightAnchor.constraint(equalToConstant: 30),
            locationImage.widthAnchor.constraint(equalToConstant: 30),
            locationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76),

            locationLabel.heightAnchor.constraint(equalTo: locationImage.heightAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            timeImage.heightAnchor.constraint(equalTo: locationImage.heightAnchor),
            timeImage.widthAnchor.constraint(equalTo: locationImage.widthAnchor),
            timeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76),

            timeLabel.heightAnchor.constraint(equalTo: ratingImage.heightAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            ratingImage.heightAnchor.constraint(equalTo: locationImage.heightAnchor),
            ratingImage.widthAnchor.constraint(equalTo: locationImage.widthAnchor),
            ratingImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76),

            ratingLabel.heightAnchor.constraint(equalTo: ratingImage.heightAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            dateImage.heightAnchor.constraint(equalTo: ratingImage.heightAnchor),
            dateImage.widthAnchor.constraint(equalTo: ratingImage.widthAnchor),
            dateImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76),

            dateLabel.heightAnchor.constraint(equalTo: ratingLabel.heightAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with viewModel: EventViewModel) {
        nameLabel.text = viewModel.name
        locationLabel.text = viewModel.location
        timeLabel.text = viewModel.mode
        ratingLabel.text = viewModel.ratingType
        dateLabel.text = viewModel.date
    }
}
