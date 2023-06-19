/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/swiftui/
 https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-start-an-animation-immediately-after-a-view-appears
 https://betterprogramming.pub/swiftui-tutorial-basic-animations-edb78c97eb01
 https://www.youtube.com/watch?v=Ck7uN5ZKzf8
 */

//Read and parse JSON file
import Foundation

//Declare Player struct
struct Player: Codable {
    var firstName, lastName, yearOfBirth: String
    var age: Int
    var height, weight, bestFoot, citizenship, avatar, marketValue, description: String
    var backgroundColor: String
    var twitter: String
    var instagram: String
    var currentClub, position, clubLogo: String
    var totalApperances, totaGloals, totalAssists: Int
    
    //perform the read and parse json then add to the array
    static let allPlayer: [Player] = decodeJson(file: "playerJSON.json")
}

//Read and parse function
func decodeJson(file: String) -> [Player]{
    //JSON file does not exist
    guard let path = Bundle.main.path(forResource: "playerJSON", ofType: "json") else {
        fatalError("Could not find \(file) in the project!")
    }
    
    //URL to the json file is not correct
    let url = URL(fileURLWithPath: path)
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Could not load \(file) in the project!")
    }
    
    //JSON file has some attributes that not fit the Player struct
    let decoder = JSONDecoder()
    guard let loadedData = try? decoder.decode([Player].self, from: data) else {
        fatalError("Could not decode \(file) in the project!")
    }
    return loadedData
}

