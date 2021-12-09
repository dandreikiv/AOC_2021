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
            let signal = components[0].components(separatedBy: " ")
            let output = components[1].components(separatedBy: " ")

            var patterns: [Int: [Set<Character>]] = [:]
            for pattern in signal {
                patterns[pattern.count, default: []] += [Set(pattern)]
            }

            let one = patterns[2]![0]
            let seven = patterns[3]![0]
            let four = patterns[4]![0]
            let eight = patterns[7]![0]
            let three = patterns[5]!.filter { $0.intersection(seven).count == 3 }[0]
            let nine = four.union(three)
            let zero = patterns[6]!.filter { $0.intersection(seven).count == 3 }.filter { $0 != nine }[0]
            let six = patterns[6]!.filter { $0 != nine && $0 != zero }[0]
            let five = six.subtracting(eight.subtracting(nine)) 
            let two = patterns[5]!.filter { $0 != three && $0 != five }[0] 

            let dict: [Set<Character>: Int] = [zero: 0, one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9]

            var number = 0
            for patter in output {                
                if let digit = dict[Set(patter)] {
                    number *= 10
                    number += digit
                }
            }
            result += number
        }

        return result
    }
}
let solution = Solution()
print(solution.solve())
