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
import SwiftUI

//Data
let players: [Player] = Player.allPlayer
let numberOfPlayerImages: Int = 3

//Color
let primaryColor: Color = Color("primaryColor")
let secondaryColor: Color = Color("secondaryColor")

//Timer to slide image
let time = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
