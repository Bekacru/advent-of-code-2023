import Foundation

let input = try! String(contentsOf: URL(filePath: "./inputs/input-2.txt"), encoding: .utf8)

let possibleCubes = [
  "red": 12,
  "green": 13,
  "blue": 14,
]

func extractNumber(from input: String) -> Int? {
  var numberString = ""
  for character in input {
    if let digit = Int(String(character)) {
      numberString.append(String(digit))
    } else if !numberString.isEmpty {
      break
    }
  }
  return Int(numberString)
}

func getGameId(line: String) -> Int {
  return extractNumber(from: String(line.split(separator: ":")[0]))!
}

var answer = 0
var answer2 = 0
for line in input.split(separator: "\n") {
  let gameId = getGameId(line: String(line))
  let gameSets = line.split(separator: ":")[1].split(separator: ";")
  var isPossible = true
  var result = ["green": 0, "red": 0, "blue": 0]

  for sets in gameSets {
    for cube in sets.split(separator: ",") {
      let data = cube.split(separator: " ", maxSplits: 2)
      let key = String(data[1])
      let value = Int(String(data[0]))
      result[key]! < value! ? result[key] = value : ()  //for part 2
      if let value {
        if value > possibleCubes[key]! {
          isPossible = false
        }
      }
    }
  }
  if isPossible {
    answer += gameId
  }
  answer2 += result.values.reduce(1, *)  //for part 2
}

print(answer, answer2)
