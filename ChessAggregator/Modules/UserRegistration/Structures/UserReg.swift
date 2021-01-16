//
// Created by Иван Лизогуб on 19.11.2020.
//

import Foundation

struct UserReg {
        let lastName: String
        let firstName: String
        let patronymicName: String?
        let sex: Sex
        let latinName: String
        let fideID: String
        let frcID: String
        let email: String
        let password: String
        let passwordValidation: String
        let isOrganizer: Bool
        let organisationCity: String?
        let organisationName: String?
        let birthdate: Date
}
struct UserForgot {
        let email: String?
}

