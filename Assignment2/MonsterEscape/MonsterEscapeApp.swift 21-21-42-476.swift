/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 21/08/2022
 Last modified: 29/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/coredata
 https://www.advancedswift.com/fetch-requests-core-data-swift/
 https://cocoacasts.com/adding-core-data-to-an-existing-swift-project-fetching-data-from-a-persistent-store
 https://www.hackingwithswift.com/forums/swiftui/playing-sound/4921
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
 https://www.youtube.com/watch?v=cpg7f4pVzFw
 */

import SwiftUI

@main
struct MonsterEscapeApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var currentPlayer = CurrentPlayer()
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(currentPlayer)
        }
    }
}
