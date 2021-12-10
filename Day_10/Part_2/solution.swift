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
            input = string.components(separatedBy: "\n")
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        let scores: [Character: Int] = [
            "(": 1,
            "[": 2,
            "{": 3,
            "<": 4
        ]
        let incompleteLines: [String] = input.compactMap { checkLine($0) }
        var totalScores: [Int] = []
        for line in incompleteLines {
            var total = 0
            for char in line.reversed() {
                let points = scores[char, default: 0]
                total = total * 5 + points
            }
            totalScores.append(total)
        } 

        return totalScores.sorted()[totalScores.count / 2]
    }

    private func checkLine(_ line: String) -> String? {
        var stack: [Character] = []
        let openingBrackets = Set<Character>("{[(<")
        let closingBrackets = Set<Character>(">)}]")
        let pairs: [Character: Character] = [
            "}": "{", 
            "]": "[",
            ")": "(",
            ">": "<"
        ] 

         for char in line {
            if stack.isEmpty {
                stack.append(char)
            } else {
                if stack.count > 0 {
                    let topChar = stack[stack.count - 1] // last element, top of the stack
                    if openingBrackets.contains(char) {
                        stack.append(char)
                    } else if closingBrackets.contains(char) {
                        if let opening = pairs[char] {
                            if topChar == opening {
                                stack.removeLast() // remove top
                            } else {
                                // invalid char
                                return nil
                            }
                        }
                    }
                }                
            }
        }
        return String(stack)
    }
}

let solution = Solution()
print(solution.solve())
