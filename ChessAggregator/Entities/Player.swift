import Foundation

struct Player: Codable {
    var lastName: String = "Доу"
    var firstName: String = "Джон"
    var patronomicName: String? = nil
    var birthdate: Date = Calendar.current.date(from: DateComponents(year: 1953, month: 2, day: 25))!
    var sex: Sex = .male
    var latinName: String = "Doe John"

    var fideID: Int? = 24176214
    var classicFideRating: Int?
    var rapidFideRating: Int?
    var blitzFideRating: Int?
    var frcID: Int? = 1606
    var classicFrcRating: Int?
    var rapidFrcRating: Int?
    var blitzFrcRating: Int?

}

enum Sex: String, Codable, CaseIterable {
    case male = "Мужчина"
    case female = "Женщина"
}
