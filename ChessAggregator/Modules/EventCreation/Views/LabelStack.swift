//
// Created by Administrator on 07.12.2020.
//

import UIKit

class LabelStack: UIStackView {
    init(first: String, second: String, third: String) {
        super.init(frame: .zero)

        let firstLabel = UILabel()
        let secondLabel = UILabel()
        let thirdLabel = UILabel()

        firstLabel.text = first
        secondLabel.text = second
        thirdLabel.text = third

        firstLabel.font = .systemFont(ofSize: 12, weight: .light)
        firstLabel.textColor = .lightGray
        secondLabel.font = .systemFont(ofSize: 12, weight: .light)
        secondLabel.textColor = .lightGray
        thirdLabel.font = .systemFont(ofSize: 12, weight: .light)
        thirdLabel.textColor = .lightGray

        firstLabel.textAlignment = .center
        secondLabel.textAlignment = .center
        thirdLabel.textAlignment = .center

        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 2

        addArrangedSubview(firstLabel)
        addArrangedSubview(secondLabel)
        addArrangedSubview(thirdLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
