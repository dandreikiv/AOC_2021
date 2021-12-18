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
            for line in string.components(separatedBy: "\n") {
                input.append(line.compactMap { Int(String($0)) } )
            }
        } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var rows = input.count
        var cells = input[0].count

        var fullmap = Array(repeating: Array(repeating: 0, count: cells * 5), count: rows * 5)
        
        for i in 0..<5 {
            for j in 0..<5 {
                for row in 0..<rows {
                    for cell in 0..<cells {
                        let value = input[row][cell] + i + j
                        fullmap[rows * i + row][cells * j + cell] = value > 9 ? value - 9 : value
                    }
                }
            }
        }
    
        input = fullmap

        rows = input.count
        cells = input.count

        let hfunc: ([Int]) -> Int = { node in abs(node[0] - rows) + abs(node[1] - cells) }
        let result = astart(matrix: input, start: [0, 0], goal: [rows - 1, cells - 1], h: hfunc)

        return result
    }

    func astart(matrix: [[Int]], start: [Int], goal: [Int], h: ([Int]) -> Int) -> Int {
        let rows = matrix.count
        let cells = matrix.count

        var openSet: Set<[Int]> = Set(arrayLiteral: start)

        var gScore: [[Int]: Int] = [:]
        gScore[start] = 0

        var fScore: [[Int]: Int] = [:]
        fScore[start] = h(start)

        while openSet.isEmpty == false {
            guard let current = openSet.min(by: { fScore[$0, default: Int.max] < fScore[$1, default: Int.max] }) else {
                return Int.min
            }

            if current == goal {
                return gScore[goal, default: Int.min]
            }

            openSet.remove(current)
            for node in adjacentNodes(current, rows, cells) {
                let tentative_gScore = gScore[current, default: Int.max] + matrix[node[0]][node[1]]
                if tentative_gScore < gScore[node, default: Int.max] {
                    gScore[node] = tentative_gScore
                    fScore[node] = tentative_gScore + h(node)

                    if openSet.contains(node) == false {
                        openSet.insert(node)
                    }
                }
            }
        }

        return Int.min
    }

    func adjacentNodes(_ node: [Int], _ rows: Int, _ cells: Int) -> [[Int]] {
        let row = node[0]
        let cell = node[1]

        return [ [1, 0], [-1, 0], [0, 1], [0, -1] ].compactMap { d in
            guard row + d[0] >= 0 && row + d[0] < rows && cell + d[1] >= 0 && cell + d[1] < cells else { 
                return nil 
            } 
            return [row + d[0], cell + d[1]]
        }
    }
}

let solution = Solution()
print(solution.solve())
