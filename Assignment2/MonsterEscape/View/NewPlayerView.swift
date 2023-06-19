/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 17/08/2022
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
import CoreData

struct NewPlayerView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    var players: FetchedResults<Player>
    
    @State private var name = ""
    @State private var score = 0
    @State private var showError = false
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
                    HStack {
                        Spacer()
                        //Back button
                        Button(action: {
                            withAnimation {
                                viewRouter.currentPage = .menuPage
                            }}) {
                                Image("back")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                            }
                            .padding(.trailing,20)
                    }
                    Spacer()
                    
                    //Insert new player
                    Image("introduction")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/2, height: geo.size.height/12, alignment: .center)
                    
                    Spacer()
                    //check the existance from Core data then show error
                    if(showError) {
                        Text("This name is already taken!")
                            .foregroundColor(.red)
                            .bold()
                            .font(.title2)
                    }
                    //Text field
                    HStack {
                        TextField("name", text: $name)
                    }
                    .textFieldStyle(OvalTextFieldStyle())
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showError = false
                                for player in players {
                                    if(player.name == name || name.isEmpty) {
                                        showError = true
                                    }
                                }
                                if(!showError) {
                                    viewRouter.currentPage = .difficultyView
                                    DataController().addPlayer(name: name, score: 0, achievement: "", context: managedObjContext)
                                    dismiss()
                                    currentPlayer.name = name                                }
                            }
                        }) {
                            Image("explore")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                
            }
        }
    }
    
}

struct NewPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerView()
            .environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
    }
}


