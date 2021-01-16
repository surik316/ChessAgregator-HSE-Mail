import Foundation
import SwiftKeychainWrapper
import CommonCrypto


func sha512( string: String) -> String {
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
    if let data = string.data(using: String.Encoding.utf8) {
        let value =  data as NSData
        CC_SHA512(value.bytes, CC_LONG(data.count), &digest)

    }
    var digestHex = ""
    for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
        digestHex += String(format: "%02x", digest[index])
    }

    return digestHex
}


func getMethod(url: String) {
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    // Create the url request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
    do {
        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            print("Error: Cannot convert data to JSON object")
            return
        }
        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            print("Error: Cannot convert JSON object to Pretty JSON data")
            return
        }
        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
            print("Error: Could print JSON in String")
            return
        }
        print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
                }.resume()
}

