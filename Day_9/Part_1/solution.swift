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
        var result: [Int] = []
        
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
                    result.append(input[row][cell])
                }
            }
        }

        return result.reduce(0) { $0 + $1 + 1}
    }
}

let solution = Solution()
print(solution.solve())
