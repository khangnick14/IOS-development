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

//HEADER
struct Header: View {
    //variable to keep track the animation
    @State private var isAnimating: Bool = false
    var player: Player
    var body: some View {
        HStack(spacing: 1) {
            //basic information
            VStack(alignment: .leading, spacing: 5) {
                Text(player.firstName)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text(player.lastName)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .scaleEffect(1.15, anchor: .leading)
                HStack{
                    Text("\(player.citizenship), \(player.yearOfBirth)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    //add club logo
                    Image("\(player.currentClub.lowercased().replacingOccurrences(of: " ", with: ""))")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                }
                
                //social media section
                HStack {
                    //add link to social media
                    Link(destination: URL(string: player.instagram)!, label: {
                        Image("instagram")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30, height: 30)
                    })
                    Link(destination: URL(string: player.twitter)!, label: {
                        Image("twitter")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30, height: 30)
                    })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(y: isAnimating ? 40 : 0)
            
            //player avatar with animation
            Image("\(player.lastName.lowercased())_header")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,height: 300, alignment: .trailing)
                .offset(y: isAnimating ? 40 : 0)
            
        }
        //add animation to the whole header when isanimating
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating.toggle()
            }
        })
        .offset(y:-60)
        .padding(.horizontal,15)
        .padding(.vertical,40)
        .background(Color(player.backgroundColor).opacity(0.9))
        .cornerRadius(30)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(player: players[0]).background(Color(players[0].backgroundColor))
    }
}
