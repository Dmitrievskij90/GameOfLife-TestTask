//
//  GameFieldView.swift
//  GameOfLife-TestTask
//
//  Created by Konstantin Dmitrievskiy on 07.07.2022.
//

import UIKit

class GameFieldView: UIView {
    var isPlaying = false
    private var cellCount = 50
    private var timer: Timer?
    private var cells = [[CellView]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawGrid()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // create a playing field
    private func drawGrid() {
        for x in 0..<cellCount {
            var row: [CellView] = []
            for y in 0..<cellCount {
                
                let worldWidth = UIScreen.main.bounds.width
                let cellSize = Int((worldWidth / CGFloat(cellCount)).rounded(.awayFromZero))
                
                let cellView = CellView(frame: CGRect(x: (x * cellSize), y: y * cellSize , width: cellSize, height: cellSize))
                cellView.backgroundColor = .white
                cellView.layer.borderColor = UIColor.darkGray.cgColor
                cellView.layer.borderWidth = 0.5
                addSubview(cellView)
                row.append(cellView)
            }
            cells.append(row)
        }
    }
    
    // MARK: - Game logic
    // change state depending on the number of neighbors
    private func changeState(_ x: Int, _ y: Int, neighborsCount: Int) {
        if self.cells[x][y].backgroundColor == UIColor.white {
            if neighborsCount == 3 {
                self.cells[x][y].state = .alive
            }
        } else {
            if neighborsCount == 2 || neighborsCount == 3 {
                self.cells[x][y].state = .alive
            }
            if neighborsCount > 3 {
                self.cells[x][y].state = .dead
            }
            if neighborsCount < 2 {
                self.cells[x][y].state = .dead
            }
        }
    }
    
    // count neighbors
    private func countNeighbors(_ x: Int, _ y: Int){
        var neighborsCount = 0
        for xOffset in -1...1 {
            for yOffset in -1...1 {
                if !(xOffset == 0 && yOffset == 0) {
                    if self.cells[x + xOffset][y + yOffset].backgroundColor == UIColor.black {
                        neighborsCount += 1
                    }
                }
            }
        }
        changeState(x, y, neighborsCount: neighborsCount)
    }
    
    // change the color of the cell depending on the state
    private func changeCellColor() {
        for x in 1..<self.cellCount-1 {
            for y in 1..<self.cellCount-1 {
                if self.cells[x][y].state == .alive {
                    self.cells[x][y].backgroundColor = .black
                } else if self.cells[x][y].state == .dead {
                    self.cells[x][y].backgroundColor = .white
                }
            }
        }
    }
    
    // MARK: - Actions
    // start or stop the simulation
    func startButtonPressed() {
        isPlaying.toggle()
        if isPlaying {
            timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
                for x in 1..<self.cellCount-1 {
                    for y in 1..<self.cellCount-1 {
                        self.countNeighbors(x, y)
                    }
                }
                self.changeCellColor()
            }
        } else {
            timer?.invalidate()
        }
    }
    
    // fill in the simulation field randomly
    func randomButtonPressed() {
        for x in 0..<cellCount {
            for y in 0..<cellCount {
                let randomInt = Int.random(in: 0...5)
                cells[x][y].state = randomInt == 0 ? .alive : .dead
                cells[x][y].backgroundColor = randomInt == 0 ? .black : .white
            }
        }
    }
}

