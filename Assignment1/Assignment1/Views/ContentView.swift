/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 22/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/swiftui/
 https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-start-an-animation-immediately-after-a-view-appears
 */
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabBarView()
        }
        .ignoresSafeArea()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
