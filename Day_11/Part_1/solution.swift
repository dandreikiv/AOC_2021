import Foundation

class Solution {

    private var input: [[Int]] = []
    private let chars: [Character: Int] = ["1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "0": 0]

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.components(separatedBy: "\n").map { line in line.compactMap { chars[$0] } }
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        input.forEach {
            print($0)
        }

        let rows = input.count
        let colls = input[0].count
        var count = 0

        var a = input 
        for step in 1...100 {
            var highlighted: [[Bool]] = input.map { $0.map { _ in false } }

            var list: [[Int]] = []
            for i in 0..<rows {
                for j in 0..<colls {
                    a[i][j] += 1
                    if a[i][j] > 9 {
                        list.append([i, j])
                    }
                }
            }

            while list.count > 0 {
                for item in list {
                    highlighted[item[0]][item[1]] = true
                    for next in adjacentElements(item[0], item[1]) {
                        a[next[0]][next[1]] += 1            
                    }
                }

                list = []
                for i in 0..<rows {
                    for j in 0..<colls {
                        if a[i][j] > 9 && highlighted[i][j] == false {
                            list.append([i, j])
                        }
                    }
                }
            }

            for i in 0..<rows {
                for j in 0..<colls {
                    if a[i][j] > 9 {
                        a[i][j] = 0
                        count += 1
                    }
                }
            }
        }
        return count
    }

    func printMatrix(_ matrix: [[Int]]) {
        matrix.forEach {
            print($0.map {
                if $0 > 9 { return "(\($0))"}
                return String($0)
            }.joined(separator: "\t"))
        }
    }

    private func adjacentElements(_ row: Int, _ col: Int) -> [[Int]] {
        var result: [[Int]] = []
        let rows = input.count
        let colls = input[0].count
        // let delta = [[1, 1], [1, -1], [1, 0], [-1, 1], [-1, -1], [-1, 0], [0, 1], [0, -1]]
    
        for di in -1...1 {
            for dj in -1...1 {
                // if di == dj && di == 0 { continue }

                let newRow = row + di
                let newCol = col + dj
                if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < colls {
                    result.append([newRow, newCol])
                }     
            } 
        }
        return result
    }
}

let solution = Solution()
print(solution.solve())
