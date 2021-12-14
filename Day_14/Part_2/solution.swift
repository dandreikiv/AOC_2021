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
        
        var charCounts: [Character: Int] = [:]
        var pairsCount: [String: Int] = [:]
        
        for i in 0..<pattern.count - 1 {
            let key = String([pattern[i], pattern[i + 1]])
            pairsCount[key, default: 0] += 1
        }
        
        for char in pattern {
            charCounts[char, default: 0] += 1
        }

        var nextPairs: [String: Int] = [:]
        for _ in 1...40 {
            for (key, value) in pairsCount {
                let chars = key.map { $0 }
                if let ins = pairs[key] {
                    charCounts[ins, default: 0] += value
                    
                    let leftPair = String([chars[0], ins])
                    let rightPair = String([ins, chars[1]])
                    nextPairs[leftPair, default: 0] += value
                    nextPairs[rightPair, default: 0] += value
                }
            }

            pairsCount = nextPairs
            nextPairs = [:]
        }

        var minValue = Int.max
        var maxValue = Int.min

        for (_, value) in charCounts {
            minValue = min(minValue, value)
            maxValue = max(maxValue, value)
        }

        return maxValue - minValue
    }
}

let solution = Solution()
print(solution.solve())
