import Foundation

class Solution {

    private var input: [String] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.split(separator: "\n").compactMap(String.init) 
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> Int {
        var depth = 0
        var horizontalPosition = 0
        for line in input {
            let parts = line.split(separator: " ")
            let command = String(parts[0])
            let value = Int(parts[1]) ?? 0

            switch command {
                case "forward": 
                    horizontalPosition += value
                case "down":
                    depth += value
                case "up":
                    depth -= value
                default:
                    break
            }
        }
        return depth * horizontalPosition
    }
}

let solution = Solution()
print(solution.solve())

