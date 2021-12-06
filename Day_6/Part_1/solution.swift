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
            input = string.split(separator: ",").compactMap(String.init).compactMap(Int.init)
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        var day = 1
        while day <= 256 {
            var index = 0
            let count = input.count
            while index < count {
                input[index] -= 1
                if input[index] < 0 {
                   input[index] = 6
                   input.append(8)
               }
               index += 1
            }
            day += 1
            print(day, input.count)
        }
        return input.count
    }
}

let solution = Solution()
print(solution.solve())

