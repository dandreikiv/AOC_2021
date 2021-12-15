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
        var queue: [[Int]] = [[0, 0]]
        var visited: [[Bool]] = input.map { $0.map { _ in false } }
        
        let rows = input.count
        let cells = input[0].count

        var distances: [[Int]] = input.map { $0.map { _ in Int.max } }
        var nextQueue: Set<[Int]> = Set()
        
        distances[0][0] = 0

        while queue.isEmpty == false {
            let node = queue.removeFirst()
            visited[node[0]][node[1]] = true

            let adjacent = adjacentNodes(node[0], node[1], rows, cells).filter { visited[$0[0]][$0[1]] == false }
            for next in adjacent {
                let row = next[0]
                let cell = next[1]
                let nextValue = input[next[0]][next[1]]
                
                if visited[row][cell] == false {
                    nextQueue.insert(next)
                    let nodeDistance = distances[node[0]][node[1]]
                    distances[row][cell] = min(distances[row][cell], nodeDistance + nextValue)
                } 
            }

            if queue.isEmpty {
                queue = Array(nextQueue)
                for next in queue {
                    input[next[0]][next[1]] = distances[next[0]][next[1]]
                }
                nextQueue = Set()
            }
        }
        return input[rows - 1][cells - 1]
    }

    func adjacentNodes(_ row: Int, _ cell: Int, _ rows: Int, _ cells: Int) -> [[Int]] {
        let directions: [[Int]] = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]
        
        return directions.compactMap { d in
            guard row + d[0] >= 0 && row + d[0] < rows && cell + d[1] >= 0 && cell + d[1] < cells else { 
                return nil 
            } 
            return [row + d[0], cell + d[1]]
        }
    }
}

let solution = Solution()
print(solution.solve())
