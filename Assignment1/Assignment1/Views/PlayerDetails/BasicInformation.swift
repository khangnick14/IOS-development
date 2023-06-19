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

struct BasicInformation: View {
    var player: Player
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            //Background information
            Text("Background")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(primaryColor)
            VStack(alignment: .leading, spacing: 6) {
                //Age and Best Foot
                HStack {
                    HStack {
                        Text("Age: ")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("\(player.age)")
                            .font(.body)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: 5, height: 30)
                        .cornerRadius(3)
                    HStack {
                        Text("Foot: ")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(player.bestFoot)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                
                //Weight and height
                HStack {
                    HStack {
                        Text("Weight: ")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("\(player.weight)")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: 5, height: 30)
                        .cornerRadius(3)
                    
                    HStack {
                        Text("Height: ")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(player.height)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                
                //Market Value and Current Club
                HStack {
                    HStack {
                        Text("Market value: ")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(player.marketValue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: 5, height: 30)
                        .cornerRadius(3)
                    HStack {
                        Text("Club: ")
                            .font(.title3)
                            .fontWeight(.bold)
                        Image("\(player.currentClub.lowercased().replacingOccurrences(of: " ", with: ""))")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                //Nationality
                HStack {
                    Text("Nationality: ")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(player.citizenship)
                }
                
                //Best Position
                HStack {
                    Text("Position: ")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(player.position)
                }
                
            }
            .padding(.vertical,15)
            
            //Description
            Text("Description")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(primaryColor)
                .padding(.top,15)
            Text(player.description)
                .font(.body)
                .fontWeight(.medium)
                .padding(.top,15)
                .padding(.bottom,60)
        }
        .padding(.horizontal,25)
        .padding(.vertical,10)
    }
}


struct BasicInformation_Previews: PreviewProvider {
    static var previews: some View {
        BasicInformation(player: players[0])
    }
}
