//
// Created by Administrator on 05.12.2020.
//

import UIKit

class MaterialTextField: UITextField {
    init() {
        super.init(frame: .zero)
        backgroundColor = Styles.Color.tinyGray
        clipsToBounds = false
        layer.cornerRadius = 12
//        layer.shadowRadius = 2
//        layer.shadowOpacity = 0.5


        font = UIFont.systemFont(ofSize: 24)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    var textInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) {
        didSet { setNeedsDisplay() }
    }

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
