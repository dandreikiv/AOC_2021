import Foundation

class Solution {

    private var input: [Int] = []

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.components(separatedBy: ",").compactMap(Int.init)
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var minSum = Int.max
        for i in input {
            var sum = 0
            for j in input {
                sum += abs(i - j)
            }
            minSum = min(minSum, sum)
        }
        return minSum
    }
}

let solution = Solution()
print(solution.solve())

