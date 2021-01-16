//
//  Picker-readyTextField.swift
//  ChessAggregator
//
//  Created by Николай Пучко on 03.01.2021.
//

import UIKit


class PickableTextField: MaterialTextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
}
