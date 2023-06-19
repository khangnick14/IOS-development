/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 22/08/2022
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
import AVFoundation

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                //Background
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                Spacer()
                VStack(alignment: .center, spacing: 50) {
                    //Header: Greeting current player
                    HStack {
                        Text("Greetings \(currentPlayer.name)")
                            .padding(.leading,20)
                            .padding(.top,40)
                            .foregroundColor(.red)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                        Spacer()
                    }
                    //Game Title
                    Image("title")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width/2, height: geo.size.height/13, alignment: .center)
                        .padding(.top,50)
                    Spacer()
                    
                    //Check condition to show the "CONTINUE" button
                    if currentPlayer.name != "" {
                        Button(action: {
                            withAnimation {
                                viewRouter.currentPage = .difficultyView
                            }
                        }) {
                            Image("continue")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                        }
                    }
                    
                    //Menu: START + LEADERBOARD + HOW TO PLAY
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .newPlayerView
                        }
                    }) {
                        Image("start")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                    }
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .leaderboardPage
                        }
                    }) {
                        Image("leaderboard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                    }
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .howToPlayPage
                        }                    }) {
                            Image("howtoplay")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                        }
                    Spacer()
                }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                Spacer()
            }
        }
        //Start the menu play music and loop
        .onAppear(perform: {
            print("play")
            playSound(sound: "backgroundMusic", type: "wav")
            audioPlayer?.numberOfLoops = 100
        })
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
    }
}
