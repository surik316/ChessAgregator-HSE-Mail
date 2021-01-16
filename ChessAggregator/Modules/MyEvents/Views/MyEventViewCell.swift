//
// Created by Иван Лизогуб on 10.12.2020.
//

import UIKit

class MyEventViewCell<T: UIView>: UICollectionViewCell {

    let containerView: T

    override init(frame: CGRect) {
        containerView = T(frame: frame)
        super.init(frame: frame)
        contentView.addSubview(containerView)
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("not supported MyEventViewCell")
    }

    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pins()
    }
}
