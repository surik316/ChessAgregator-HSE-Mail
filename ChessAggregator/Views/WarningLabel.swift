//
// Created by Иван Лизогуб on 17.11.2020.
//

import Foundation
import UIKit

class WarningLabel: UILabel {
    init() {
        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.textColor = .systemRed
        self.font = .boldSystemFont(ofSize: 15.0)
        self.isHidden = true
        self.numberOfLines = 0
    }

    func animatedAppearance(isHidden: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromLeft,
                animations: {self.isHidden = isHidden}, completion: nil)
    }
}


class AnimatedLabel: UILabel {
    init() {
        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.textColor = .black
        self.font = .boldSystemFont(ofSize: 20)
        self.isHidden = true
    }

    func animatedAppearance(isHidden: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromLeft,
                animations: {self.isHidden = isHidden}, completion: nil)
    }
}

class AnimatedTextField: UITextField {
    init() {
        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
    }

    func animatedAppearance(isHidden: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromLeft,
                animations: {self.isHidden = isHidden}, completion: nil)
    }
}
