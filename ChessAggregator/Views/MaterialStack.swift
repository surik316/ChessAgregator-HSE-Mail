//
//  MaterialStack.swift
//  ChessAggregator
//
//  Created by Николай Пучко on 03.01.2021.
//

import UIKit

class MaterialStack: UIStackView {
    private let textField: MaterialTextField
    private let label: InsetLabel = {
        let label = InsetLabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    init(name: String, field: MaterialTextField) {
        label.text = name
        textField = field
        
        super.init(frame: .zero)
        addArrangedSubview(textField)
        addArrangedSubview(label)
        //alignment = .leading
        //distribution = .fillProportionally
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
