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
    private var list: [[String]] = []

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
        dfs("start", Set(), ["start"])
        return list.count
    }

    private func dfs(_ node: String, _ visited: Set<String>, _ path: [String]) {
        if node == "end" { 
            list.append(path)
            return
        }

        if visited.contains(node) {
            return
        }

        var nextSet = visited
        if node.isLowercased {
            nextSet.insert(node)
        }

        for next in input[node, default: Set()] {
            dfs(next, nextSet, path + [next])    
        } 
    }
}

let solution = Solution()
print(solution.solve())
