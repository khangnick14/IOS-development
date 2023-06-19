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

struct LoadingScreenView: View {
    //variable to support the animation
    @State private var isActive = false //check if the view is current active
    @State private var size = 0.8  //inital size
    @State private var opacity = 0.5 //inital opacity
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    //Load image from asset
                    Image("loading")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    //App name
                    Text("Favorite Football Players")
                        .font(Font.custom("Gill Sans SemiBold", size: 40))
                        .foregroundColor(Color(.red).opacity(0.8))
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.2   ), radius: 2, x: 10, y: 10)
                    
                }
                //set initial value
                .scaleEffect(size)
                .opacity(opacity)
                //animation
                .onAppear {
                    withAnimation(.easeOut(duration: 1.5)) {
                        self.size = 0.9
                        self.opacity = 1
                    }
                }
            }
            //When this view starts, set animation duration and the variable to true
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

struct LoadingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreenView()
    }
}
