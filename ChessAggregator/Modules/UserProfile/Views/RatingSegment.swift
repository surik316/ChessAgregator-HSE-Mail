//
// Created by Иван Лизогуб on 08.01.2021.
//

import UIKit

class RatingSegment: AutoLayoutView {

    let ratingSegmentStack = UIStackView()

    let ratingType = UILabel()

    private let labelStack = UIStackView()
    private let classicLabel = UILabel()
    private let rapidLabel = UILabel()
    private let blitzLabel = UILabel()

    private let ratingStack = UIStackView()
    let classicRating = UILabel()
    let rapidRating = UILabel()
    let blitzRating = UILabel()

    init(ratingType: String) {
        super.init(frame: .zero)
        self.ratingType.text = ratingType
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init not supported RatingSegment")
    }

    private func setup() {

        ratingType.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        addSubview(ratingType)

        classicLabel.text = "Классика: "
        classicLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)

        rapidLabel.text = "Рапид: "
        rapidLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)

        blitzLabel.text = "Блиц: "
        blitzLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)

        labelStack.axis = .vertical
        labelStack.distribution = .fillEqually
        labelStack.alignment = .trailing
        labelStack.addArrangedSubview(classicLabel)
        labelStack.addArrangedSubview(rapidLabel)
        labelStack.addArrangedSubview(blitzLabel)

        classicRating.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        rapidRating.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        blitzRating.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)

        ratingStack.axis = .vertical
        ratingStack.distribution = .fillEqually
        ratingStack.alignment = .leading
        ratingStack.addArrangedSubview(classicRating)
        ratingStack.addArrangedSubview(rapidRating)
        ratingStack.addArrangedSubview(blitzRating)

        ratingSegmentStack.axis = .horizontal
        ratingSegmentStack.distribution = .fillProportionally
        ratingSegmentStack.alignment = .fill
        ratingSegmentStack.addArrangedSubview(labelStack)
        ratingSegmentStack.addArrangedSubview(ratingStack)

        addSubview(ratingSegmentStack)
    }

    override func setupConstraints() {
        super.setupConstraints()

        ratingSegmentStack.topAnchor.constraint(equalTo: ratingType.bottomAnchor, constant: -5.0).isActive = true
        ratingSegmentStack.leadingAnchor.constraint(equalTo: ratingType.trailingAnchor, constant: 15.0).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: ratingSegmentStack.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: ratingType.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: ratingType.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: ratingSegmentStack.trailingAnchor).isActive = true
    }

    func ratingSegmentSubviews(isHidden: Bool) {
        labelStack.isHidden = isHidden
        ratingStack.isHidden = isHidden
    }

    func updateRatings(classic: String, rapid: String, blitz: String) {
        classicRating.text = classic
        rapidRating.text = rapid
        blitzRating.text = blitz
    }

}