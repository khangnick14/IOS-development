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

struct PlayerCellList: View {
    var player: Player
    var body: some View {
        ZStack {
            HStack {
                //Player Name and current club
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(player.firstName) \(player.lastName)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    HStack {
                        //format name of the club to the corresponding club's image name
                        Image("\(player.currentClub.lowercased().replacingOccurrences(of: " ", with: ""))")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 40)
                        Text("\(player.currentClub)")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                Spacer()
                //Player avatar
                Image("\(player.avatar)")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(height: 100)
                    .padding(.trailing,25)
                
            }
            .frame(width: UIScreen.main.bounds.width / 1.2)
            .padding()
            .background(Color(player.backgroundColor).opacity(0.9))
            .cornerRadius(10)
        }
    }
}

struct PlayerCellList_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCellList(player: players[0])
    }
}
