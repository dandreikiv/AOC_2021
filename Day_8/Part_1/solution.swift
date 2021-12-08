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
            input = string.replacingOccurrences(of: "|\n", with: "| ").components(separatedBy: "\n")
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var result = 0

        for line in input {
            let components = line.components(separatedBy: "|").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            let signal = components[0].components(separatedBy: " ").map(\.count)
            let output = components[1].components(separatedBy: " ").map(\.count)

            var counts: [Int: Int] = [:]
            for number in signal {
                counts[number, default: 0] += 1
            }

            for digit in output {
                if let count = counts[digit], count == 1 {
                    result += 1
                }
            }
        }
        return result
    }
}

let solution = Solution()
print(solution.solve())
