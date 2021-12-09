import Foundation

class Solution {

    private var input: [[Int]] = []

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            let lines = string.components(separatedBy: "\n")
            for line in lines {
                let numbers = line.map(String.init).compactMap(Int.init)
                input.append(numbers)
            }
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        let rows = input.count
        let cells = input[0].count

        let directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
        var lowPoint: [[Int]] = []
        
        for row in 0..<rows {
            for cell in 0..<cells {
                var minValue = Int.max
                for d in directions {
                    let newRow = row + d[0]
                    let newCell = cell + d[1]

                    if newRow >= 0 && newRow < rows && newCell >= 0 && newCell < cells {
                        minValue = min(minValue, input[newRow][newCell])
                    }
                }

                if minValue > input[row][cell] {
                    lowPoint.append([row, cell])
                }
            }
        }
        
        return lowPoint.map { pos in findArea(input, pos[0], pos[1]) }.sorted(by: >)[0...2].reduce(1, *)
    }

    func findArea(_ matrix: [[Int]], _ row: Int, _ cell: Int) -> Int {
        var visited: [[Bool]] = matrix.map { $0.map { _ in false } }
        var queue: [[Int]] = [[row, cell]]

        let directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
        var result = 0
        while queue.isEmpty == false {
            let pos = queue.removeFirst()
            visited[pos[0]][pos[1]] = true

            for d in directions {
                let newRow = pos[0] + d[0]
                let newCell = pos[1] + d[1]
                if newRow >= 0 && newRow < matrix.count && newCell >= 0 && newCell < matrix[0].count {
                    if visited[newRow][newCell] == false && matrix[newRow][newCell] < 9 {
                        visited[newRow][newCell] = true
                        queue.append([newRow, newCell])
                    }
                }
            }
            result += 1
        }

        return result
    }
    
}

let solution = Solution()
print(solution.solve())
