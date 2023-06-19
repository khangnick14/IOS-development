/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 19/08/2022
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

struct DifficultyView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    var body: some View {
        GeometryReader { geo in
            ZStack {
                //background
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack {
                    HStack {
                        Spacer()
                        //Back button
                        Button(action: {
                            withAnimation {
                                viewRouter.currentPage = .menuPage
                            }}) {
                                Image("back")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                            }
                            .padding(.trailing,20)
                    }
                    Spacer()
                    
                    //Easy: TimeLimit is 3 minutes
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .gamePage
                            currentPlayer.chosenTimeLimit = 180
                        }
                    }) {
                        Text("Easy")
                    }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    
                    //Medium: time limit is 2 minutes
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .gamePage
                            currentPlayer.chosenTimeLimit = 120
                        }
                    }) {
                        Text("Medium")
                    }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    
                    //Hard: time limit is 1 minute
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .gamePage
                            currentPlayer.chosenTimeLimit = 60
                        }
                    }) {
                        Text("Hard")
                    }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    Spacer()
                }
            }
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView()
            .environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
    }
}
