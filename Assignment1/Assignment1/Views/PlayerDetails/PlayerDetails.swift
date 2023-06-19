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

struct PlayerDetails: View {
    let player: Player
    var body: some View {
        ZStack {
            Color("grayB")
            ScrollView {
                VStack(spacing: 1){
                    //header
                    Header(player: player)
                    //player statistic
                    PlayerStats(player: player)
                        .offset(y:-50)
                    //player media - some images
                    ImageSlider(player: player)
                        .offset(y:-30)
                    //basic information
                    BasicInformation(player:player)
                    Spacer()
                }
                .cornerRadius(30)
                .frame(alignment: .top)
            }
        }
        .ignoresSafeArea(.all)
    }
}



struct PlayerDetails_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetails(player: players[6])
    }
}
