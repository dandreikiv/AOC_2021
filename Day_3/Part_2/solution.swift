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
        var array: [[Character]] = []

        for string in input {
            array.append(string.map{$0})
        }

        let oxygen = findRating(array) { (ones, zeros) in
            ones.count >= zeros.count ? ones : zeros  
        }

        let co2 = findRating(array) { (ones, zeros) in
            zeros.count <= ones.count ? zeros : ones  
        }

        let oxygenRating = intFromCharacters(oxygen) 
        let co2Rating = intFromCharacters(co2)
    
        return oxygenRating * co2Rating
    }

    func findRating(_ data: [[Character]], modifier: ([[Character]], [[Character]]) -> [[Character]]) -> [Character] {
        let length = data[0].count
        var array = data
        var i = 0
        while array.count > 1 && i < length {
            var zeroNumbers: [[Character]] = []        
            var oneNumbers: [[Character]] = []
            
            for number in array {
                if number[i] == "1" {
                    oneNumbers.append(number)
                } else {
                    zeroNumbers.append(number)
                }
            }
            
            array = modifier(oneNumbers, zeroNumbers)

            i = i + 1
        }
        return array[0]
    }

    func intFromCharacters(_ list: [Character]) -> Int {
        var result: Int = 0
        for (i, n) in list.reversed().enumerated() {
            if n == "1" {
                result |= 1 << i 
            }
        }
        return result
    }
}

let solution = Solution()
print(solution.solve())