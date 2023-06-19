/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 17/08/2022
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

class Cell: ObservableObject {
    let images = ["view1", "view2", "view3"] //normal view
    var row: Int
    var column: Int
    var randomNormalView: String
    
    @Published var status : Status
    @Published var isDiscovered: Bool
    @Published var isMagicSealed: Bool
    var image: Image {
        if !isDiscovered && isMagicSealed {
            return Image("magic-seal")
        }
        switch status {
        case .monster:
            if isDiscovered {
                playSound(sound: "gameOverMusic", type: "wav")
                return Image("monster")
            }
            return Image("glass")
        case .normal:
            return Image("glass")
            
        case .exposed(let total):
            if !isDiscovered {
                return Image("glass")
            }
            if total == 0 {
                return Image(randomNormalView)
            }
            return Image("\(total)")
        }
        
    }
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        self.status = .normal
        self.isDiscovered = false
        self.isMagicSealed = false
        self.randomNormalView = images.randomElement()!
    }
    
    
}
