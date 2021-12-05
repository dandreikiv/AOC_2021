import Foundation

struct Line {
    let start: Point
    let finish: Point 

    init(string: String) {
        let component = string.components(separatedBy: " -> ")
        start = Point(string: component[0])
        finish = Point(string: component[1])
    }

    func points() -> [Point] {
        var result: [Point] = []

        if start.x == finish.x {
            let minY = min(start.y, finish.y)
            let maxY = max(start.y, finish.y) 
            for y in minY...maxY {
                result.append(Point(x: start.x, y: y))
            }
        } else if start.y == finish.y {
            let minX = min(start.x, finish.x)
            let maxX = max(start.x, finish.x) 
            for x in minX...maxX {
                result.append(Point(x: x, y: start.y))
            } 
        }

        return result
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int 

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(string: String) {
       let coordinate = string.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",").compactMap { Int(String($0)) }  
       x = coordinate[0]
       y = coordinate[1]
    }
}

class Solution {

    private var input: [String] = []
    private var lines: [Line] = []
    private var crossedPoints: [Point: Int] = [:]

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.split(separator: "\n").compactMap(String.init) 
            for row in input {
                let line = Line(string: row)
                if line.start.x == line.finish.x || line.start.y == line.finish.y {
                    lines.append(line)
                }
            }
       } catch {
            print(error)
        }
    }

    func solve() -> Int {
        let points = lines.reduce([Point]()) { $0 + $1.points() }
        for point in points {
            crossedPoints[point, default: 0] += 1
        }

        var res = 0
        for (_ , value) in crossedPoints {
            if value > 1 {
                res = res + 1
            }
        }
        
        return res
    }
}

let solution = Solution()
print(solution.solve())

