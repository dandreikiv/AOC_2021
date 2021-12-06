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
        let totalDays = 256
        var mem: [Int: Int] = [:]
        var result = 0
        
        for n in input {
            if let savedResult = mem[n] {
                result += savedResult 
            } else {
                let res = getNumbers(0, n, totalDays) 
                mem[n] = res
                result += res
            }
        }
        
        return result + input.count
    }
    func getNumbers(_ day: Int, _ state: Int, _ totalDays: Int) -> Int {
        var nextDay = day + state + 1
        
        if nextDay > totalDays { 
            return 0 
        }
        
        var sum = 0
        while nextDay <= totalDays {
            sum += 1 + getNumbers(nextDay, 8, totalDays)
            nextDay += 7
        }   
             
        return sum
    }
}

let solution = Solution()
print(solution.solve())

