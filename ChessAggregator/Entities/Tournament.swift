import Foundation

struct Tournament: Identifiable{
    var id: String

    var organizerId: String
    var name: String
    var mode: Mode
    var openDate: String
    var closeDate: String
    var location: String
    var ratingType: RatingType
    var tours: Int
    var participantsCount: Int = 0

    //var timeControl: String
    var minutes: Int
    var seconds: Int
    var increment: Int
    var prizeFund: Int
    var fee: Int
    var url: URL

    // TODO: class Date - DateFormatter!
    // TODO: class Location

    init(id: String = "0", organizerId: String = "", name: String = "Some event", mode: Mode = .classic, openDate: String = "01.01.1970",
         closeDate: String = "01.01.1970", location: String = "Moscow", ratingType: RatingType = .without,
         tours: Int = 9, minutes: Int = 1, seconds: Int = 0, increment: Int = 0,
         prizeFund: Int = 0, fee: Int = 0, url: URL = URL(string: "https://vk.com/oobermensch")!) {
        self.id = id
        self.organizerId = organizerId
        self.name = name
        self.mode = mode
        self.openDate = openDate
        self.closeDate = closeDate
        self.location = location
        self.ratingType = ratingType
        self.tours = tours
        self.minutes = minutes
        self.seconds = seconds
        self.increment = increment
        self.prizeFund = prizeFund
        self.fee = fee
        self.url = url
    }
}

enum Mode: String, Codable, CaseIterable{
    case classic = "Классика", rapid = "Рапид", blitz = "Блиц", bullet = "Пуля", fide = "Классика FIDE", chess960 = "Шахматы 960"
}

enum RatingType: String, Codable, CaseIterable{
    case fide = "FIDE", russian = "ФШР", without = "Без обсчёта"
}
