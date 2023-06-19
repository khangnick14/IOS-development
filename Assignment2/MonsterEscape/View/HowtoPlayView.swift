/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 16/08/2022
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

struct HowtoPlayView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
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
                    //Title
                    Image("howtoplay")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width/1.2, height: geo.size.height/5)
                    Spacer()
                    ZStack {
                        //Guide information
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.9))
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.5)
                        VStack(spacing: 10) {
                            Text("You are the new King of this wonderland. Trying to expand your kingdom by clicking on each land on the map,  However, there will be some monsters wandering around")
                                .frame(width: geo.size.width/1.2,alignment: .center)
                            Text("Try to avoid them or you will be killed!")
                                .foregroundColor(.red)
                                .frame(width: geo.size.width/1.2, alignment: .leading)
                            Text("However, you can use your power to seal the monster by click and hold the square")
                                .foregroundColor(.green)
                                .frame(width: geo.size.width/1.2, alignment: .leading)
                            
                            //Guide photo
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Image("glass")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Spacer()
                                    Text("Undiscovery").foregroundColor(.gray)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                }
                                HStack {
                                    Image("magic-seal")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Spacer()
                                    Text("Magic Seal").foregroundColor(.purple)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                }
                                HStack {
                                    Image("monster")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Spacer()
                                    Text("Monster").foregroundColor(.red)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                }
                                
                                HStack {
                                    Image("1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Image("2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Spacer()
                                    Text("Hint").foregroundColor(.blue)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                }
                                HStack {
                                    Image("view1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Image("view2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Image("view3")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width/10, height: geo.size.height/20, alignment: .leading)
                                    Spacer()
                                    Text("Land").foregroundColor(.green)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                    
                                }
                                
                            }.frame(width: geo.size.width/1.2, alignment: .leading)
                            
                        }
                    }
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .menuPage
                        }}) {
                            Image("back")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width/4, height: geo.size.height/10)
                        }
                        .frame(alignment: .trailing)
                }
            }
        }
        
    }
}

struct HowtoPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowtoPlayView()
            .environmentObject(ViewRouter())
    }
}
