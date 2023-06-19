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
import Foundation
import AVFoundation


class GameLogic: ObservableObject {
    
    //The game settings
    @Published var setting: Settings
    
    //The game map
    @Published var map: [[Cell]]
    @Published var showResult: Bool = false
    @Published var isWon: Bool = false
    
    //Initialize the map with given numbers of monsters
    private static func createMap(from setting: Settings) -> [[Cell]] {
        var newMap = [[Cell]]()
        
        for row in 0..<setting.numsOfRow {
            var column = [Cell]()
            for col in 0..<setting.numsOfColumn {
                column.append(Cell(row: row, column: col))
            }
            newMap.append(column)
        }
        // Add monster
        var monsterPlaced: Int = 0
        while monsterPlaced < setting.numsOfMonster {
            //random number for monster's position
            let randomX = Int.random(in: 0..<setting.numsOfRow)
            let randomY = Int.random(in: 0..<setting.numsOfColumn)
            
            //check duplicate position
            let currentCellStatus = newMap[randomX][randomY].status
            if currentCellStatus != .monster {
                newMap[randomX][randomY].status = .monster
                monsterPlaced += 1
            }
        }
        return newMap
    }
    
    func click(on cell:Cell) {
        //click on revealed cell, do nothing
        if case Cell.Status.exposed( _ ) = cell.status {
            return
        }
        
        //click on magic sealed cell, do nothing
        if (cell.isMagicSealed){
            return;
        }
        //click on the monster, we lose
        if cell.status == .monster {
            playSound(sound: "gameOverMusic", type: "wav")
            cell.isDiscovered = true
            showResult = true
            isWon = false;
        } else {
            expandAllNormalView(for: cell)
        }
        //we won the game
        if(isWinning()){
            showResult = true
            isWon = true
        }
        self.objectWillChange.send()
    }
    
    func reset() {
        map = Self.createMap(from: setting)
        showResult = false
        isWon = false
    }
    
    
    
    private func getExposedCount(for cell:Cell) -> Int {
        let row = cell.row
        let col = cell.column
        
        let minRow = max(row-1,0)
        let maxRow = min(row+1,map.count - 1)
        let minCol = max(col-1,0)
        let maxCol = min(col+1, map[0].count - 1)
        
        var totalMonster = 0
        for row in minRow...maxRow {
            for col in minCol...maxCol {
                if map[row][col].status == .monster {
                    totalMonster += 1
                }
            }
            
        }
        return totalMonster
    }
    
    
    private func expandAllNormalView(for cell: Cell) {
        //if cell is discovered, do nothing
        guard !cell.isDiscovered else {
            return
        }
        
        //if cell is magic-sealed, do nothing
        guard !cell.isMagicSealed else {
            return
        }
        
        let exposedCount = getExposedCount(for: cell)
        cell.status = .exposed(exposedCount)
        cell.isDiscovered = true
        if (exposedCount == 0) {
            // get the neighboring cells (top, bottom, left and right)
            // make sure they aren't passed the size of our board
            let topCell = map[max(0, cell.row - 1)][cell.column]
            let bottomCell = map[min(cell.row + 1, map.count - 1)][cell.column]
            let leftCell = map[cell.row][max(0, cell.column - 1)]
            let rightCell = map[cell.row][min(cell.column + 1, map[0].count - 1)]
            
            expandAllNormalView(for: topCell)
            expandAllNormalView(for: bottomCell)
            expandAllNormalView(for: leftCell)
            expandAllNormalView(for: rightCell)
        }
        playSound(sound: "revealMusic", type: "wav")
    }
    
    func sealTheMonster(on cell: Cell) {
        //is cell is discovered, do nothing
        guard !cell.isDiscovered else {
            return
        }
        cell.isMagicSealed = !cell.isMagicSealed
        if(isWinning()){
            showResult = true
            isWon = true
        }
        self.objectWillChange.send()
        playSound(sound: "magicSealMusic", type: "wav")
        
    }
    
    //initialize the game settings
    init(from setting: Settings) {
        self.setting = setting
        map = Self.createMap(from: setting)
        
    }
    
    //winning condition: If there is no more normal view
    func isWinning() -> Bool {
        for row in 0..<setting.numsOfRow{
            for col in 0..<setting.numsOfColumn{
                //If board contains normal cell, it means game is still going on.
                if(map[row][col].status == .normal){
                    return false;
                }
            }
        }
        return true;
    }
}
