//
// Created by Иван Лизогуб on 10.12.2020.
//

import UIKit

class MyEventView: UIView {

    private let container = UIView()

    private let tourName: PaddedLabel = {
        let label = PaddedLabel(frame: .zero, inset: UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 0))
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        label.text = "orgName   lkdsk jkdskljdkla jasdlkajslkd"
        label.textColor = .gray
        label.backgroundColor = .systemGray6
        return label
    }()

    private let image = UIImageView()

    private let tourTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Тип турнира"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        label.layer.cornerRadius = Constant.cornerRadius
        label.clipsToBounds = true
        return label
    }()

    private let tourType: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        label.text = "Классика"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        label.layer.cornerRadius = Constant.cornerRadius
        label.clipsToBounds = true
        return label
    }()

    private let averageRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Средний ЭЛО"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return label
    }()

    private let averageRating: UILabel = {
        let rating = UILabel()
        rating.text = "1505"
        rating.textColor = .blue
        rating.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return rating
    }()

    private let prizeFundLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Приз. фонд"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return label
    }()

    private let prizeFund: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        label.text = "200.000.000 ₽"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return label
    }()

    private let numberOfParticipantsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Кол-во уч-ов:"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return label
    }()

    private let numberOfParticipants: UILabel = {
        let number = UILabel()
        number.text = "200"
        number.textColor = .blue
        number.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return number
    }()

    private let openDate: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "19.02.1998 - "
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return label
    }()

    private let closeDate: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "20.02.1999 "
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        return label
    }()

    private let location: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.text = "Москва"
        label.font = UIFont(name: "Copperplate-Light", size: Constant.font)
        label.layer.cornerRadius = Constant.cornerRadius
        label.clipsToBounds = true
        return label
    }()

    private let middleStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fill
        result.alignment = .fill
        result.spacing = 15.0
        return result
    }()

    private let infoStack: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fillEqually
        result.alignment = .fill
        return result
    }()

    private let tourTypeStack: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        result.alignment = .fill
        result.spacing = 15.0
        return result
    }()

    private let prizeStack: UIStackView  = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        result.alignment = .fill
        result.spacing = 15.0
        return result
    }()

    private let participantsStack: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        result.alignment = .fill
        result.spacing = 15.0
        return result
    }()

    private let averageRatingStack: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        result.alignment = .fill
        result.spacing = 15.0
        return result
    }()

    private let dateVerticalStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fill
        result.alignment = .center
        result.layer.cornerRadius = Constant.cornerRadius
        result.clipsToBounds = true
        return result
    }()

    private let dateHorizontalStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fill
        result.alignment = .center
        result.layer.cornerRadius = Constant.cornerRadius
        result.clipsToBounds = true
        return result
    }()

    private let dateAndLocationStack: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fill
        result.spacing = 5.0
        return result
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("not supported for ViewCell")
    }

    private func setup() {
        addSubview(container)

        container.backgroundColor = .white
        container.layer.cornerRadius = Constant.cornerRadius
        container.clipsToBounds = true

        container.addSubview(tourName)
        container.addSubview(middleStackView)
        container.addSubview(dateAndLocationStack)

        middleStackView.addArrangedSubview(image)
        middleStackView.addArrangedSubview(infoStack)

        infoStack.addArrangedSubview(tourTypeStack)
        infoStack.addArrangedSubview(prizeStack)
        infoStack.addArrangedSubview(participantsStack)
        infoStack.addArrangedSubview(averageRatingStack)

        tourTypeStack.addArrangedSubview(tourTypeLabel)
        tourTypeStack.addArrangedSubview(tourType)

        prizeStack.addArrangedSubview(prizeFundLabel)
        prizeStack.addArrangedSubview(prizeFund)

        participantsStack.addArrangedSubview(numberOfParticipantsLabel)
        participantsStack.addArrangedSubview(numberOfParticipants)

        averageRatingStack.addArrangedSubview(averageRatingLabel)
        averageRatingStack.addArrangedSubview(averageRating)

        dateVerticalStackView.addArrangedSubview(dateHorizontalStackView)

        dateAndLocationStack.addArrangedSubview(dateVerticalStackView)
        dateAndLocationStack.addArrangedSubview(location)

        dateHorizontalStackView.addArrangedSubview(openDate)
        dateHorizontalStackView.addArrangedSubview(closeDate)

        image.backgroundColor = .blue
    }

    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        dateVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        dateHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        tourName.translatesAutoresizingMaskIntoConstraints = false
        openDate.translatesAutoresizingMaskIntoConstraints = false
        averageRating.translatesAutoresizingMaskIntoConstraints = false
        numberOfParticipants.translatesAutoresizingMaskIntoConstraints = false
        tourTypeStack.translatesAutoresizingMaskIntoConstraints = false
        dateAndLocationStack.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false

        container.pins()

        let margins = safeAreaLayoutGuide

        tourName.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tourName.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        tourName.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tourName.heightAnchor.constraint(equalToConstant: bounds.height/8).isActive = true

        middleStackView.horizontal(10.0, trailing: -10.0)
        middleStackView.topAnchor.constraint(equalTo: tourName.bottomAnchor, constant: 10.0).isActive = true
        middleStackView.bottomAnchor.constraint(equalTo: dateAndLocationStack.topAnchor, constant: -10.0).isActive = true

        image.widthAnchor.constraint(equalTo: middleStackView.widthAnchor, multiplier: 0.4).isActive = true

        dateAndLocationStack.horizontal(10.0, trailing: -10.0)
        dateAndLocationStack.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8.0).isActive = true
        dateAndLocationStack.heightAnchor.constraint(equalToConstant: 30.0).isActive = true

        location.widthAnchor.constraint(equalTo: dateAndLocationStack.widthAnchor, multiplier: 0.3).isActive = true
    }

    func update(with viewModel: MyEventViewModel) {
        tourName.text = viewModel.name
        tourType.text = viewModel.tourType
        prizeFund.text = viewModel.prize
        openDate.text = viewModel.startDate
        closeDate.text = viewModel.endDate
        location.text = viewModel.location
        averageRating.text = viewModel.averageRating
        numberOfParticipants.text = viewModel.participantsCount
    }
    
}

private struct Constant {
    static let cornerRadius: CGFloat = 10.0
    static let font: CGFloat = 15.0
}