/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 02/08/2022
 Last modified: 07/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/swiftui/
 https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-start-an-animation-immediately-after-a-view-appears
 https://betterprogramming.pub/swiftui-tutorial-basic-animations-edb78c97eb01
 */

import SwiftUI

struct ImageSlider: View {
    var player: Player
    //variable to keep track of current image index
    @State var currentImageIndex = 0
    
    var body: some View { GeometryReader{ proxy in
        //geometry reader to get the width and height
        let frame = proxy.frame(in: .global)
        TabView(selection: $currentImageIndex) {
            ForEach(0..<numberOfPlayerImages, id:\.self) { num in
                //get image from asset based on the player name
                Image("\(player.lastName.lowercased())_\(num+1)")
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.1))
                    .frame(width: frame.width, height: frame.height , alignment: .center)
                    .cornerRadius(15)
                
                
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onReceive(time, perform: { _ in
            withAnimation {
                currentImageIndex = currentImageIndex < numberOfPlayerImages ? currentImageIndex + 1 : 0
            }
        })
    }
    .frame(height: 200, alignment: .center)
    .padding(.horizontal,10)
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(player: players[0])
    }
}
