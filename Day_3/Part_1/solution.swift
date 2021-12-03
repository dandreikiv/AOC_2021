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
        let lineLength = input[0].count 
        var counts: [Int] = Array(repeating: 0, count: lineLength)
        for string in input {
            for (i, ch) in string.enumerated() {
                if ch == "1" {
                    counts[i] += 1
                }
            }
        }
        var gamma = 0
        var epsilon = 0
        for (i, n) in counts.reversed().enumerated() {
            let number = 1 << i 
            if n > input.count / 2 {
                gamma |= number
            } else {
                epsilon |= number
            }
        }

        return gamma * epsilon
    }
}

let solution = Solution()
print(solution.solve())

