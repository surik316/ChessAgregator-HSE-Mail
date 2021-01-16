//
// Created by Иван Лизогуб on 15.12.2020.
//

import UIKit

class PaddedLabel: UILabel {
    private let inset: UIEdgeInsets

    init(frame: CGRect, inset: UIEdgeInsets) {
        self.inset = inset
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("not supported")
    }

    override func drawText(in rect: CGRect) {
        let r = rect.inset(by: inset)
        super.drawText(in: r)
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let b = bounds
        let tr = b.inset(by: inset)
        let ctr = super.textRect(forBounds: tr, limitedToNumberOfLines: 0)
        return ctr
    }
}
