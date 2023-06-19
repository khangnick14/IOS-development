/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 24/08/2022
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

struct LeaderboardView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.managedObjectContext) var managedObjContext
    
    //Fetch players
    @FetchRequest(sortDescriptors: [SortDescriptor(\.score, order: .reverse)]) var player: FetchedResults<Player>
    
    var body: some View {
        //Initialize some data
        NavigationView {
            ZStack {
                //background
                Color.blue
                    .opacity(0.2)
                    .ignoresSafeArea()
                VStack() {
                    //Back to menu button
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .menuPage
                        }}) {
                            Image("back")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                        }
                        .frame(alignment: .trailing)
                    //Show list of players in leaderboard
                    List {
                        //display the fetch result to list
                        ForEach(player) {player in
                            NavigationLink(destination: Text("\(player.score)")) {
                                HStack {
                                    Text(player.name!).bold()
                                        .font(.system(size:20, design: .rounded))
                                    Spacer()
                                    Text("\(Int(player.score))")
                                }
                            }
                        }
                        //add delete option
                        .onDelete(perform: deletePlayer)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            //add title
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("LEADERBOARD")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.blue)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            
        }
        //fetch data
        .onAppear(perform: {
            @FetchRequest(sortDescriptors: [SortDescriptor(\.score, order: .reverse)]) var player: FetchedResults<Player>
        })
    }
    //delete player in the list
    private func deletePlayer(offsets: IndexSet) {
        withAnimation {
            offsets.map {player[$0]}.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView().environmentObject(ViewRouter())
    }
}
