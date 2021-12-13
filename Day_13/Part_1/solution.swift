import Foundation

class Solution {

    private var input: [[String]] = []
    private var instructions: [[Int]] = []

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            var coordinates: [[Int]] = []
            for line in string.components(separatedBy: "\n") {
                if line.contains(",") {
                    let coordinate = line.components(separatedBy: ",").compactMap { Int($0) }
                    coordinates.append(coordinate)
                } else if line.contains("y=") {
                    let y = Int(line.components(separatedBy: "y=")[1]) ?? 0
                    instructions.append([y,0])
                } else if line.contains("x=") {
                    let x = Int(line.components(separatedBy: "x=")[1]) ?? 0
                    instructions.append([0,x]) 
                }
            }

            var maxX = Int.min
            var maxY = Int.min
            for coordiante in coordinates {
                maxX = max(coordiante[0], maxX)
                maxY = max(coordiante[1], maxY)
            }

            print("maxX: \(maxX)", "maxY: \(maxY)")

            input = Array(repeating: Array(repeating: ".", count: maxX + 1), count: maxY + 1)

            for coordiante in coordinates {
                input[coordiante[1]][coordiante[0]] = "#"
            }
        } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var res = 0
        // input.forEach { print($0.joined()) }
        let rows = input.count
        let cols = input[0].count
        for index in 0..<instructions.count {
            let instruction = instructions[index]
            let row = instruction[0]
            let col = instruction[1]

            if col == 0 {
                for i in (row + 1)..<rows {
                    for j in 0..<cols {
                        if input[i][j] == "#" {
                            let target = i - (i - row) * 2
                            if target >= 0 {
                                input[target][j] = "#"
                            }
                            input[i][j] = "."
                        }
                    }
                }
                // print("after folding horizontaly\n")
                // input.forEach { print($0.joined()) }
            } else if row == 0 {
                for i in 0..<rows {
                    for j in (col + 1)..<cols {
                        if input[i][j] == "#" {
                            let target = j - (j - col) * 2
                            if target >= 0 {
                                input[i][target] = "#"
                            }
                            input[i][j] = "."
                        }
                    }
                }
            }

            if index == 0 {
                res = input.flatMap{ $0 }.filter { $0 == "#" }.count
            }
        }

        var maxX = Int.min
        var maxY = Int.min

        for i in 0..<input.count {
            for j in 0..<input[0].count {
                if input[i][j] == "#" {
                    maxX = max(j, maxX)
                    maxY = max(i, maxY)
                }
            }
        }    

        var result = Array(repeating: Array(repeating: ".", count: maxX + 1), count: maxY + 1)

        for i in 0...maxY {
            for j in 0...maxX {
                if input[i][j] == "#" {
                    result[i][j] = "#"
                }
            }
        }    

        print("\n")
        result.forEach { print($0.joined()) }

        return res
    }
}

let solution = Solution()
print(solution.solve())
