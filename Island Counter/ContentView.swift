//
//  ContentView.swift
//  Island Counter
//
//  Created by Nsengimana Veda Dominique on 15/10/2022.
//
import SwiftUI


struct ContentView: View {
    @State var grid = Array(repeating: Array(repeating: 0, count: 6), count: 10)
    @State var islandCount = 0
    var body: some View {
        VStack(alignment: .leading) {
            Text("Island Count: \(islandCount)")
            // grid view to display the grid
            GridView(grid: $grid, islandCount: $islandCount)
            Spacer().frame(height: 16)
            // button to reset the grid
            Button(action: {
                self.grid = Array(repeating: Array(repeating: 0, count: 6), count: 10)
                self.islandCount = 0
            }) { Text("Reset") } .frame(minWidth: 0, maxWidth: .infinity) .padding() .foregroundColor(.white) .background(Color.blue) .cornerRadius(8)
            
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct GridView: View {
    @Binding var grid: [[Int]]
    @Binding var islandCount: Int
    var body: some View {
        VStack {
            ForEach(0..<grid.count, id: \.self) { row in
                HStack {
                    ForEach(0..<self.grid[row].count, id: \.self) { column in
                        Button(action: {
                            self.grid[row][column] = self.grid[row][column] == 0 ? 1 : 0
                            self.islandCount = self.findIslands(grid: self.grid)
                        }) {
                            if self.grid[row][column] == 0 {
                                Text("  ")
                            } else {
                                Text("🏝")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(self.grid[row][column] == 0 ? Color.gray.opacity(0.1) : Color.gray.opacity(0.6))
                    }
                }
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
    
    func findIslands(grid: [[Int]]) -> Int {
        var grid = grid
        var islandCount = 0
        for row in 0..<grid.count {
            for column in 0..<grid[row].count {
                if grid[row][column] == 1 {
                    islandCount += 1
                    findIslands(grid: &grid, row: row, column: column)
                }
            }
        }
        return islandCount
    }
    
    func findIslands(grid: inout [[Int]], row: Int, column: Int) {
        if row < 0 || row >= grid.count || column < 0 || column >= grid[row].count || grid[row][column] == 0 {
            return
        }
        grid[row][column] = 0
        findIslands(grid: &grid, row: row + 1, column: column)
        findIslands(grid: &grid, row: row - 1, column: column)
        findIslands(grid: &grid, row: row, column: column + 1)
        findIslands(grid: &grid, row: row, column: column - 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
