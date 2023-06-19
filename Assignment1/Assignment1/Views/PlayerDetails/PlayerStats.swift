/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 26/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/swiftui/
 https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-start-an-animation-immediately-after-a-view-appears
 https://betterprogramming.pub/swiftui-tutorial-basic-animations-edb78c97eb01
 */

import SwiftUI

struct PlayerStats: View {
    var player: Player
    var body: some View {
        //HStack with three sections
        HStack {
            //Apperances
            VStack {
                Text("\(player.totalApperances)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Text("Apperances")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            
            //Goals
            VStack {
                Text("\(player.totaGloals)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Text("Goals")
                    .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity)
            
            //Assists
            VStack {
                Text("\(player.totalAssists)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Text("Assists")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical,15)
        .background(.white.opacity(0.97))
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.3), radius: 20, x:5, y:10)
    }
}

struct PlayerStats_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStats(player: players[0])
    }
}
