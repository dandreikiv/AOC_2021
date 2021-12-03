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
        var array:[[Character]] = []
        for string in input {
            array.append(string.map{$0})
        }

        let oxygen = findOxygenRating(array)
        let co2 = findCORating(array)

        let oxygenRating = intFromCharacters(oxygen)
        let co2Rating = intFromCharacters(co2)
    
        return oxygenRating * co2Rating
    }

    func findOxygenRating(_ data: [[Character]]) -> [Character] {
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
                if oneNumbers.count >= zeroNumbers.count {
                    array = oneNumbers
                } else {
                    array = zeroNumbers
                }
            }
            i = i + 1
        }
        return array[0]
    }

    func findCORating(_ data: [[Character]]) -> [Character] {
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
                if zeroNumbers.count <= oneNumbers.count  {
                    array = zeroNumbers
                } else {
                    array = oneNumbers
                }
            }
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