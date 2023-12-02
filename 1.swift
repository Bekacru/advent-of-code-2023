import Foundation

let input = try! String(contentsOf: URL(filePath: "./inputs/input-1.txt"), encoding: .utf8)

func calibrator(input: String) -> String {
  let lines = input.split(separator: "\n")
  let numbers = lines.map {
    line in
    var firstNum: Int?
    var lastNum: Int?
    line.forEach {
      char in
      if char.isNumber {
        if firstNum != nil {
          lastNum = Int(String(char))
        } else {
          firstNum = Int(String(char))
        }
      }
    }
    if let lastNum {
      return firstNum! * 10 + lastNum
    } else {
      return firstNum! * 10 + firstNum!
    }
  }

  return String(numbers.reduce(0, +))
}

let strMap = [
  "one": "o1e",
  "two": "t2o",
  "three": "t3e",
  "four": "f4r",
  "five": "f5e",
  "six": "s6x",
  "seven": "s7n",
  "eight": "e8t",
  "nine": "n9e",
]
var newInput = input
strMap.forEach { newInput = newInput.replacingOccurrences(of: $0.key, with: $0.value) }

print(calibrator(input: input), calibrator(input: newInput))
