//
// Created by Иван Лизогуб on 05.12.2020.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import SwiftSoup

class UserParser {
    static let dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()


    static func userToFirebaseUser(user: User) -> [String: Any] {
        var result: [String: Any] = [:]

        
        let rates = RateParser(frcID: user.player.frcID ?? 0)
        result = [ "lastName": user.player.lastName,
                   "firstName": user.player.firstName,
                   "latinName": user.player.latinName,
                   "sex": user.player.sex.rawValue,
                   "email": user.email,
                   "isOrganizer": user.isOrganizer,
                   "birthdate": UserParser.dateFormatter.string(from: user.player.birthdate)
        ]
        if rates.count != 0 {
           
            result = [ "lastName": user.player.lastName,
                       "firstName": user.player.firstName,
                       "latinName": user.player.latinName,
                       "sex": user.player.sex.rawValue,
                       "email": user.email,
                       "isOrganizer": user.isOrganizer,
                       "birthdate": UserParser.dateFormatter.string(from: user.player.birthdate)
                       
            ]
            if let rating = rates[3]{
                result["fideClassic"] = rating
            }
            if let rating = rates[4]{
                result["fideRapid"] = rating
            }
            if let rating = rates[5]{
                result["fideBlitz"] = rating
            }
            if let rating = rates[0]{
                result["frcClassic"] = rating
            }
            if let rating = rates[1]{
                result["frcRapid"] = rating
            }
            if let rating = rates[2]{
                result["frcBlitz"] = rating
            }
        }
        let fideData = parseFide(frcID: user.player.frcID ?? 0)
        if let fullname = fideData.0 {
            result["latinName"] =  fullname
        }
        if let fideId = fideData.1 {
            result["fideID"] =  fideId
        }
        if let patronomicName = user.player.patronomicName {
            result["patronomicName"] = patronomicName
        }
        if let frcID = user.player.frcID {
            result["frcID"] = frcID
        }
        if let organizationName = user.organizer.organizationName {
            result["organizationName"] = organizationName
        }
        if let organizationCity = user.organizer.organizationCity {
            result["organizationCity"] = organizationCity
        }
        return result
    }
    static func parseFide(frcID: Int) ->(String?, Int?){
        var arrayDataFide: [String]?
        let fideID: Int?
        let fullname: String?
        var result: (String?, Int?)
        guard let urlString = try? ("https://ratings.ruchess.ru/people/" + String(frcID)) else {
            
            return (nil,nil)
            
        }
        guard let myUrl = URL(string: urlString) else{ return (nil, nil) }
        
        do {
            guard let HTMLString = try? String(contentsOf: myUrl, encoding: .utf8) else { return (nil, nil) }
            let HTMLContent = HTMLString
            do{
                guard let doc = try? SwiftSoup.parse(HTMLContent) else{ return (nil, nil)}
                
                do{
                    guard let element = try? doc.select("ul").array() else{ return (nil, nil)}
                    if element.count >= 3{
                        arrayDataFide = (try? element[3].text())?.words ?? nil
                        fideID = Int(arrayDataFide![2]) ?? nil
                        fullname = (arrayDataFide![4] + " " + arrayDataFide![5])
                        result.0 = fullname
                        result.1 = fideID
                       
                    }
                    else{
                        return (nil, nil)
                    }
                    
                }
            }
        }
        return result
    }
    static func RateParser(frcID: Int) -> [Int?]{

        var result: [Int?] = []
        let  arrayRate: [String]?
        let  arrayRateFide: [String]?
        var classic: Int?
        var rapid: Int?
        var bliz: Int?
        var fideClassic: Int?
        var fideRapid: Int?
        var fideBliz: Int?
        guard let urlString = try? ("https://ratings.ruchess.ru/people/" + String(frcID)) else {
            
            return [nil, nil, nil, nil, nil, nil]
            
        }
        guard let myUrl = URL(string: urlString) else{ return  result}
        do {
            guard let HTMLString = try? String(contentsOf: myUrl, encoding: .utf8) else {
                
                return [nil, nil, nil, nil, nil, nil]
            }
            let HTMLContent = HTMLString
            do{
                let doc = try SwiftSoup.parse(HTMLContent)
                do{
                    guard let element = try? doc.select("ul").array() else{
                        result.append(classic)
                        result.append(rapid)
                        result.append(bliz)
                        return result
                    }
                  do{
            
                    guard let stringRate = try? element[2].text() else{
                        return [nil, nil, nil, nil, nil, nil]
                    }
                    arrayRate = stringRate.words
                    
                    if arrayRate?.count ?? 0 >= 21{
                        
                        if arrayRate![0] == "Классические" {
                            
                            classic = Int((arrayRate?[2])!)
                            
                            if arrayRate![7] == "Быстрые"{
                                rapid = Int((arrayRate?[9])!)
                                bliz = Int((arrayRate?[16])!)
                            }
                            else if arrayRate![7] == "Блиц"{
                                
                                bliz = Int((arrayRate?[7])!)
                                rapid = Int((arrayRate?[16])!)
                                
                            }
                        }
                        else if arrayRate![0] == "Быстрые"{
                            
                            rapid = Int((arrayRate?[2])!)
                            if arrayRate![7] == "Классические"{
                                classic = Int((arrayRate?[9])!)
                                bliz = Int((arrayRate?[16])!)
                            }
                            else if arrayRate![7] == "Блиц"{
                                
                                bliz = Int((arrayRate?[7])!)
                                classic = Int((arrayRate?[16])!)
                            }
                            
                        }
                        else if arrayRate![0] == "Блиц"{
                            
                           bliz = Int((arrayRate?[2])!)
                            
                            if arrayRate![7] == "Быстрые"{
                                rapid = Int((arrayRate?[9])!)
                                classic = Int((arrayRate?[16])!)
                            }
                            else if arrayRate![7] == "Классические"{
                                
                                classic = Int((arrayRate?[7])!)
                                rapid = Int((arrayRate?[16])!)
                            }
                            
                        }
                    }
                    else if arrayRate?.count ?? 0 >= 14{
                        
                        if arrayRate![0] == "Классические"{
                            
                            classic =  Int((arrayRate?[2])!)
                            
                            if arrayRate![7] == "Быстрые"{
                                rapid = Int((arrayRate?[9])!)
                            }
                            else if arrayRate![7] == "Блиц"{
                                bliz = Int((arrayRate?[9])!)
                            }
                        }
                        else if arrayRate![0] == "Быстрые"{
                            rapid =  Int((arrayRate?[2])!)
                            
                            if arrayRate![7] == "Классические"{
                                classic = Int((arrayRate?[9])!)
                            }
                            else if arrayRate![7] == "Блиц"{
                                bliz = Int((arrayRate?[9])!)
                            }
                        }
                        else if arrayRate![0] == "Блиц"{
                            bliz =  Int((arrayRate?[2])!)
                            
                            if arrayRate![7] == "Классические"{
                                classic = Int((arrayRate?[9])!)
                            }
                            else if arrayRate![7] == "Быстрые"{
                                rapid = Int((arrayRate?[9])!)
                            }
                        }
                        
                        
                    }
                    else if arrayRate?.count ?? 0 >= 7{
                        
                        if arrayRate?[0] == "Классические"{
                            classic =  Int((arrayRate?[2])!)
                        }
                        else if arrayRate?[0] == "Быстрые"{
                            rapid =  Int((arrayRate?[2])!)
                        }
                        else if arrayRate?[0] == "Блиц"{
                            bliz =  Int((arrayRate?[2])!)
                        }
                        
                    }
                    else if arrayRate?.count ?? 0 == 0{
                        print("CANT PARSE")
                    }
                    do{
                        arrayRateFide = (try? element[element.count - 1].text())?.words ?? nil
                        if (arrayRateFide![arrayRateFide!.count - 1] == "Рейтинги"){
                            result.append(fideClassic)
                            result.append(fideRapid)
                            result.append(fideBliz)
                        }
                        else{
                            guard var index = (arrayRateFide?.firstIndex(of: "Рейтинги")) else{
                                return [classic, rapid, bliz, nil, nil, nil]
                            }
                            
                            index += 1
                            while index < arrayRateFide!.count{
                                if arrayRateFide?[index].first == "s" {
                                    fideClassic = Int((arrayRateFide?[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!)
                                }
                                else if arrayRateFide?[index].first == "r"{
                                    
                                    fideRapid = Int((arrayRateFide?[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!)
                                }
                                else if arrayRateFide?[index].first == "b"{
                                    fideBliz = Int((arrayRateFide?[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!)
                                }
                                index += 1
                                
                            }
                        }
                    }
                    
                    result.append(classic)
                    result.append(rapid)
                    result.append(bliz)
                    result.append(fideClassic)
                    result.append(fideRapid)
                    result.append(fideBliz)
                    
                   }
                }
            }
        } catch let error{
            print("Error \(error)")
        }
        return result
    }
    
    static func userFromSnapshot(snapshot: DataSnapshot) -> User {
        
        guard let userDict = snapshot.valueInExportFormat() as? NSDictionary else {return User()}
        var user = User()
        user.email = userDict["email"] as? String ?? "test@gmail.com"
        user.isOrganizer = userDict["isOrganizer"] as? Bool ?? false
        user.player = Player(
            lastName: userDict["lastName"] as? String ?? "Доу",
            firstName: userDict["firstName"] as? String ?? "Джон",
            patronomicName: userDict["patronomicName"] as! String?,
            birthdate: UserParser.dateFormatter.date(from: userDict["birthdate"] as? String ?? "1970-01-01") ?? Date(),
            sex: Sex(rawValue: userDict["sex"] as? String ?? "") ?? .male,
            latinName: userDict["latinName"] as? String ?? "Doe John",
            fideID: userDict["fideID"] as? Int ?? 0,
            classicFideRating: userDict["fideClassic"] as? Int ?? nil,
            rapidFideRating: userDict["fideRapid"] as? Int ?? nil,
            blitzFideRating: userDict["fideBlitz"] as? Int ?? nil,
            frcID: userDict["frcID"] as? Int ?? 0,
            classicFrcRating: userDict["frcClassic"] as? Int ?? nil,
            rapidFrcRating: userDict["frcRapid"] as? Int ?? nil,
            blitzFrcRating: userDict["frcBlitz"] as? Int ?? nil
        )


        if user.isOrganizer {
            user.organizer = Organizer(
                    organizationCity: userDict["organizationCity"] as? String ?? "",
                    organizationName: userDict["organizationName"] as? String ?? ""
            )
        }
        return user
    }

    static func usersFromSnapshot(snapshot: DataSnapshot) -> [User] {
        guard let userDict = snapshot.valueInExportFormat() as? [String: Any] else { return [] }
        var users: [User] = []
        for (key, value) in userDict {
            var user = User()
            let thisUser = value as! [String: Any]
            user.id = key
            user.email = thisUser["email"] as? String ?? ""
            user.isOrganizer = thisUser["isOrganizer"] as? Bool ?? false
            if user.isOrganizer {
                user.organizer = Organizer(
                        organizationCity: thisUser["organizationCity"] as? String ?? "",
                        organizationName: thisUser["organizationName"] as? String ?? "")
            }


            user.player = Player(
                    lastName: thisUser["lastName"] as? String ?? "Doe",
                    firstName: thisUser["firstName"] as? String ?? "John",
                    patronomicName: thisUser["patronomicName"] as! String?,
                    birthdate: UserParser.dateFormatter.date(from: thisUser["birthdate"] as? String ?? "1970-01-01") ?? Date(),
                    sex: Sex(rawValue: thisUser["sex"] as? String ?? "") ?? .male,
                    fideID: thisUser["fideID"] as? Int ?? 0,
                    classicFideRating: thisUser["fideClassic"] as? Int ?? nil,
                    rapidFideRating: thisUser["fideRapid"] as? Int ?? nil,
                    blitzFideRating: thisUser["fideBlitz"] as? Int ?? nil,
                    frcID: thisUser["frcID"] as? Int ?? 0,
                    classicFrcRating: thisUser["fideClassic"] as? Int ?? nil,
                    rapidFrcRating: thisUser["fideRapid"] as? Int ?? nil,
                    blitzFrcRating: thisUser["fideBlitz"] as? Int ?? nil
            )

            users.append(user)

        }

        return users
    }
}
extension String{
    var words: [String] {
        components(separatedBy: .punctuationCharacters)
                .joined()
                .components(separatedBy: .whitespaces)
                .filter{!$0.isEmpty}
    }
}
