/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 20/08/2022
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

struct CellView: View {
    @EnvironmentObject var gameLogic: GameLogic
    let cell: Cell
    
    var body: some View {
        cell.image
            .resizable()
            .scaledToFill()
            .frame(width: gameLogic.setting.squareSize, height: gameLogic.setting.squareSize, alignment: .center)
        //normal click to discover the cell
            .onTapGesture {
                gameLogic.click(on: cell)
            }
        //seal the monster
            .onTapGesture(count: 2, perform: {
                gameLogic.sealTheMonster(on: cell)
            })
            .onLongPressGesture {
                gameLogic.sealTheMonster(on: cell)
            }
    }
}


struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cell: Cell(row: 0, column: 0))
            .environmentObject(GameLogic(from: Settings()))
    }
}
