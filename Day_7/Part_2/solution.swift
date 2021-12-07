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

    private func totalSum(of n: Int) -> Int {
        if n % 2 == 0 {
            return (n + 1) * n / 2
        } else {
            return n + n * (n - 1) / 2
        }
    }

    func solve() -> Int {
        var minSum = Int.max
        let minY = input.min() ?? 0
        let maxY = input.max() ?? 0
        for i in minY...maxY {
            var sum = 0
            for j in input {
                sum += totalSum(of: abs(i - j)) 
            }
            minSum = min(minSum, sum)
        }
        return minSum
    }

    
}

let solution = Solution()
print(solution.solve())

