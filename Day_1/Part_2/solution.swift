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
            input = string.split(separator: "\n").compactMap{ Int($0) }
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> Int {
        var prev = input[0] + input[1] + input[2]
        var count = 0
        for index in 3..<input.count {
            let next = prev - input[index - 3] + input[index]
            if next > prev {
                count += 1
            }
            prev = next
        } 

        return count
    }
}

let solution = Solution()
print(solution.solve())

