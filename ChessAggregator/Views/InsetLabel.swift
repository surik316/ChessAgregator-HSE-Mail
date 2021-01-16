//
//  InsetLabel.swift
//  ChessAggregator
//
//  Created by Николай Пучко on 03.01.2021.
//

import UIKit

class InsetLabel: UILabel {
    init() {
        super.init(frame: .zero)
        textAlignment = .left
    }
    var textInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) {
        didSet { setNeedsDisplay() }
    }

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
