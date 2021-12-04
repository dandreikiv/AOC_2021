import Foundation

struct Board {
    private var collumns: [Set<Int>] = Array(repeating: Set(), count: 5)
    private var rows: [Set<Int>] = Array(repeating: Set(), count: 5)

    var elements: Set<Int> {
        var result = Set<Int>()
        for row in rows {
            result = result.union(row)
        }
        return result
    }

    init(array: [[Int]]) {
        for row in 0..<5 {
            for col in 0..<5 {
                collumns[col].insert(array[row][col])
                rows[row].insert(array[row][col])
            }
        }
    }

    func crossed(with input: Set<Int>) -> Bool {
        if input.count < 5 { return false }

        for list in collumns + rows {
            if list.subtracting(input).count == 0 { 
                return true 
            }
        }
        return false
    }
}

class Solution {

    private var input: [String] = []
    private var boards: [Board] = []
    private var numbers: [Int] = []

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.split(separator: "\n").compactMap(String.init) 
            numbers = input[0].split(separator: ",").map{ String($0).trimmingCharacters(in: .whitespacesAndNewlines) }.compactMap(Int.init)
            
            var array: [[Int]] = []
            for i in 1..<input.count {
                let line = input[i].split(separator: " ").map{ String($0).trimmingCharacters(in: .whitespacesAndNewlines) }.compactMap(Int.init)
                array.append(line)
                if array.count == 5 {
                    boards.append(Board(array: array))
                    array = []
                }
            }
        } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var bingoSet = Set<Int>()
        for n in numbers {
            bingoSet.insert(n)
            for board in boards {
                if board.crossed(with: bingoSet) {
                    return board.elements.subtracting(bingoSet).reduce(0, +) * n
                }
            }
        }
        return 0
    }
}

let solution = Solution()
print(solution.solve())

