
import Foundation
import UIKit

struct User: Codable {
    var player: Player = Player(lastName: "Doe", firstName: "John", birthdate: Date(), classicFideRating: 2100)
    var id: String = ""
    var email: String = "email@example.com"
    var isOrganizer: Bool = false
    var organizer: Organizer = Organizer(organizationCity: "Moscow", organizationName: "LUWL")
}

