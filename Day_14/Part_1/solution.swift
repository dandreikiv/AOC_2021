import Foundation

class Solution {

    private var pattern: [Character] = []
    private var pairs: [String: Character] = [:]
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            for line in string.components(separatedBy: "\n") {
                if line.isEmpty { 
                    continue 
                }
                if line.contains(" -> ") {
                    let part = line.components(separatedBy: " -> ")
                    let key = part[0]
                    let value = Character(part[1])
                    pairs[key] = value
                } else {
                    pattern = line.map { $0 }
                }
            }
        } catch {
            print(error)
        }
    }

    func solve() -> Int {
        print(String(pattern))
        for step in 1...10 {
            var index = 0
            var newPattern: [Character] = []
            while index < pattern.count - 1 {
                newPattern.append(pattern[index])
                let key = String([pattern[index], pattern[index + 1]])
                if let char = pairs[key] {
                   newPattern.append(char)
                }
                index += 1
            }
            newPattern.append(pattern[index])
            pattern = newPattern
            print("step: \(step)")
        }

        var counts: [Character: Int] = [:]
        for char in pattern {
            counts[char, default: 0] += 1
        }

        var minValue = Int.max
        var maxValue = Int.min
        for (_, value) in counts {
            minValue = min(value, minValue)
            maxValue = max(value, maxValue)
        }

        return maxValue - minValue
    }
}

let solution = Solution()
print(solution.solve())
