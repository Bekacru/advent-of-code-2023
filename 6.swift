import Foundation

let input = try! String(contentsOf: URL(filePath: "./inputs/input-6.txt"), encoding: .utf8)

let lines = input.components(separatedBy: "\n")

let times = lines[0].components(separatedBy: " ")[1...].compactMap { Int($0) }
let distances = lines[1].components(separatedBy: " ")[1...].compactMap { Int($0) }

func calculate(time: Int, distance: Int) -> Int {
  var result = 0
  for i in 0...time {
    if i * (time - i) > distance {
      result += 1
    }
  }
  return result
}

func part1() {
  var result1 = 1
  for (i, _) in times.enumerated() {
    let time = times[i]
    let distance = distances[i]
    let possible = calculate(time: time, distance: distance)
    result1 *= possible
  }
  print(result1)
}

func part2() {
  let joinedTime = Int((times.compactMap { String($0) }).joined())!
  let joinedDistance = Int((distances.compactMap { String($0) }).joined())!
  let possible = calculate(time: joinedTime, distance: joinedDistance)
  print(possible)
}

part1()
part2()
