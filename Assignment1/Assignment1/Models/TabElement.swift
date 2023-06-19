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

struct TabElement: Identifiable {
    var id = UUID()
    var icon: String
    var caption: String
    var tab: Tab
    var color: Color
}

//Initialize three tab elements
var tabElements = [
    TabElement(icon: "house", caption: "Home", tab: .home, color: primaryColor),
    TabElement(icon: "plus", caption: "Add", tab: .addNew, color: .orange),
    TabElement(icon: "gearshape", caption: "Setting", tab: .setting, color: .pink)
]

//three tabs: Home, Add new player and the Settings
enum Tab: String {
    case home
    case addNew
    case setting
}
