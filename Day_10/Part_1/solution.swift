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
            ")": 3,
            "]": 57,
            "}": 1197,
            ">": 25137
            ]
        
        var result = 0

        for line in input {
            if let invalidChar = checkLine(line), let points = scores[invalidChar] {
                result += points
            }
        }
       
        return result
    }

    private func checkLine(_ line: String) -> Character? {
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
                                return char
                            }
                        }
                    }
                }                
            }
        }
        return nil
    }
}

let solution = Solution()
print(solution.solve())
