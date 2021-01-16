//
// Created by Иван Лизогуб on 19.11.2020.
//

import Foundation

let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

extension String {
    func isPassword() -> Bool {
        passwordPredicate.evaluate(with: self)
    }
}