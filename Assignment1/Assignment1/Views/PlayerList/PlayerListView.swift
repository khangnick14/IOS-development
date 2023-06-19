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

struct PlayerListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                //background color
                Color("grayB")
                //Player List
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        //Title
                        Text("Your Favorite Football Players".uppercased())
                            .font(.title)
                            .bold()
                            .foregroundColor(primaryColor)
                            .multilineTextAlignment(.center)
                            .padding(.top, 70)
                        //Add each player information cell to the list
                        ForEach(players, id:\.firstName) {player in
                            NavigationLink(destination: PlayerDetails(player: player)){
                                PlayerCellList(player: player)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .padding(.bottom,50)
        }
        .accentColor(.white)
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
