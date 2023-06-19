/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 16/08/2022
 Last modified: 29/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/coredata
 https://www.advancedswift.com/fetch-requests-core-data-swift/
 https://cocoacasts.com/adding-core-data-to-an-existing-swift-project-fetching-data-from-a-persistent-store
 https://www.hackingwithswift.com/forums/swiftui/playing-sound/4921
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
 https://www.youtube.com/watch?v=cpg7f4pVzFw
 */

import Foundation
import SwiftUI

//enum supporting the onBoarding for Motherview
enum Page {
    case menuPage
    case gamePage
    case leaderboardPage
    case howToPlayPage
    case newPlayerView
    case difficultyView
}

//convert object to dictionary for storing the Core Data
func convertToDict(cellArray: [[Cell]]) -> [Dictionary<String, Any>] {
    var res = [Dictionary<String, Any>]()
    for row in 0..<cellArray.count {
        for col in 0..<cellArray[0].count {
            let cell = cellArray[row][col]
            var dict = Dictionary<String,Any>()
            dict["row"] = cell.row
            dict["column"] = cell.column
            dict["status"] = cell.status
            dict["isDiscovered"] = cell.isDiscovered
            dict["isMagicSealed"] = cell.isMagicSealed
            dict["randomNormalView"] = cell.randomNormalView
            res.append(dict)
        }
    }
    return res
}

//func convertToString(from object: [[String:Any]]) -> String {
//    let data = try JSONSerialization.data(withJSONObject: object)
//    return String(data: data, encoding: .utf8)!
//}
//

//Button Style
struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.font(.system(size: 30, weight: .bold, design: .rounded)).foregroundColor(.red)
            Spacer()
        }
        .padding()
        .background(Color.yellow.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

