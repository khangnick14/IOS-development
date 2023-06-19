/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 21/08/2022
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
import AVFoundation


struct MapView: View {
    @EnvironmentObject var gameLogic: GameLogic
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    //time remaining of the game
    @State private var timeRemaining = 50
    //active status of timer
    @State private var isActive = true
    //check is the time is over
    @State private var isTimeOut = false
    
    //Fetch players
    @FetchRequest(sortDescriptors: [SortDescriptor(\.score, order: .reverse)]) var player: FetchedResults<Player>
    //Initialize timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                Spacer()
                VStack (alignment: .center, spacing: 0) {
                    //Header: Greeting current player + Back button
                    HStack {
                        Text("Greetings \(currentPlayer.name)")
                            .padding(.leading,10)
                            .foregroundColor(.red)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                        Spacer()
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
                    }
                    
                    //Timer
                    ZStack {
                        Image("timeBackground")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height:100, alignment: .center)
                        Text("\(timeRemaining)")
                            .font(.title)
                            .bold()
                            .foregroundColor(timeRemaining < 7 ? .red : .white)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                    }
                    
                    //Game Map
                    ForEach(0..<gameLogic.map.count, id:\.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<gameLogic.map[row].count, id: \.self) { col in
                                CellView(cell: gameLogic.map[row][col])
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        //Timer run
        .onReceive(timer) {time in
            guard isActive else {return}
            if (timeRemaining > 0) {
                timeRemaining -= 1
            }
            if(timeRemaining == 0) {
                gameLogic.showResult = true
            }
            
        }
        //Activate timer
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
        //Check game condition then player sound + save score
        .onChange(of: gameLogic.isWon) { isWon in
            if isWon {
                playSound(sound: "winningMusic", type: "wav")
                timer.upstream.connect().cancel()
                let player = DataController().fetchPlayerByName(name: currentPlayer.name, context: managedObjContext)
                let score = calculateScore(timeLimit: currentPlayer.chosenTimeLimit, timeRemain: timeRemaining);
                print(score)
                player.score = score;
                DataController().updatePlayer(player: player, name: player.name!, score: score, achievement: "", context: managedObjContext)
                managedObjContext.reset()
                dismiss()
            }
        }
        //Intro music + set game time based on difficulty
        .onAppear() {
            playSound(sound: "startGameMusic", type: "wav")
            timeRemaining = currentPlayer.chosenTimeLimit
            
        }
        //Alert the winning or losing stage
        .alert(isPresented: $gameLogic.showResult) {
            Alert(title: Text(gameLogic.isWon ? "Wonderful!" : "Oops"),
                  message: Text(gameLogic.isWon ? "You discovered your own Kingdom" :"You were killed by a monster"),
                  primaryButton: .destructive(Text("Reset")) {
                gameLogic.reset()
                
                timeRemaining = currentPlayer.chosenTimeLimit
            }, secondaryButton: .default(Text("Back to Menu")) {
                viewRouter.currentPage = .menuPage
                stopSound(sound: "startGameMusic", type: "wav")
                stopSound(sound: "winningMusic", type: "wav")
                stopSound(sound: "gamerOverMusic", type: "wav")
                
            })
        }
    }
    
    
    //func to calculate score
    private func calculateScore(timeLimit: Int, timeRemain: Int) -> Int32 {
        if(timeLimit == 180) {
            return 10000 + Int32(timeRemain * 10)
        }
        if(timeLimit == 120){
            return 10000 + Int32(timeRemain * 100)
        }
        if(timeLimit == 60) {
            return 10000 + Int32(timeRemain * 1000)
        }
        return 0
    }
    
}

struct MapView_Previews: PreviewProvider {
    private static var settings = Settings()
    static var previews: some View {
        MapView()
            .environmentObject(GameLogic(from: settings))
            .environmentObject(CurrentPlayer())
    }
}
