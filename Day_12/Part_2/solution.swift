import Foundation

extension String {
    var isLowercased: Bool {
        self == self.lowercased()
    }

    var isUppercased: Bool {
        isLowercased == false
    }
}

class Solution {

    private var input: [String: Set<String>] = [:]

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            for line in string.components(separatedBy: "\n") {
                let component = line.components(separatedBy: "-")
                let key = component[0]
                let node = component[1]
                input[key, default: Set()].insert(node)
                if key != "start" {
                    input[node, default: Set()].insert(key)
                }                
            }
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var list: [[String]] = []
        dfs("start", [:], ["start"], &list)
        return list.count
    }

    private func dfs(_ node: String, _ visited: [String: Int], _ path: [String], _ result: inout [[String]]) {
        if node == "end" { 
            result.append(path)
            return
        }

        var visited = visited
        if node.isLowercased {
            visited[node, default: 0] += 1
        }

        for next in input[node, default: Set()] {
            if next == "start" { 
                continue 
            }
            if visited[next, default: 0] > 0 && visited.values.contains(2) {
                continue
            }
            dfs(next, visited, path + [next], &result) 
        } 
    }
}

let solution = Solution()
print(solution.solve())
