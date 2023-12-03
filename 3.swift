import Foundation

let input = try! String(contentsOf: URL(filePath: "./inputs/input-3.txt"), encoding: .utf8)
let lines = input.split(separator: "\n")

struct Symbol {
  let value: String
  let index: Int
  let line: Int

  func isNumber() -> Bool {
    if let _ = Int(value) {
      return true
    } else {
      return false
    }
  }
}

struct Line {
  let position: Int
  var data: [Symbol] = []
  init(data: String, position: Int) {
    for (i, e) in data.enumerated() {
      self.data.append(Symbol(value: String(e), index: i, line: position))
    }
    self.position = position
  }
}

struct PartNumber {
  let value: Int
  let startIndex: Int
  let endIndex: Int
  var adjacent: [Symbol] = []
  let lineLength: Int
  init(startIndex: Int, endIndex: Int, value: Int, line: Line) {
    self.startIndex = startIndex
    self.endIndex = endIndex
    self.value = value
    self.lineLength = line.data.count - 1
    let lineChars = Array(line.data)
    if startIndex > 0 {
      adjacent.append(
        Symbol(
          value: String(lineChars[startIndex - 1].value), index: startIndex - 1, line: line.position
        )
      )
    }
    if endIndex < lineLength {
      adjacent.append(
        Symbol(
          value: String(lineChars[endIndex + 1].value), index: endIndex + 1, line: line.position))
    }
  }
  mutating func appendAdjacent(line: Line) {
    let lineChars = Array(line.data)
    let start = startIndex > 0 ? startIndex - 1 : startIndex
    let end = endIndex < lineLength ? endIndex + 1 : endIndex
    let adjacentLine = lineChars[start...end]
    for (offset, ele) in adjacentLine.enumerated() {
      let symbol = Symbol(
        value: String(ele.value), index: ele.index, line: line.position)
      adjacent.append(symbol)
    }
  }
  func isValidPartNum() -> Bool {
    for ele in adjacent {
      if let _ = Int(ele.value) {
      } else {
        if ele.value != "." {
          return true
        }
      }
    }
    return false
  }

  func getGears() -> [Symbol] {
    return adjacent.filter {
      $0.value == "*"
    }
  }
}

func extract(
  line: Line, lineAbove: Line?, lineBelow: Line?
) -> [PartNumber] {
  var curNum: String = ""
  var curIndex: Int?
  var result: [PartNumber] = []
  var input = line.data
  input.append(Symbol(value: "empty", index: 0, line: 0))
  for (i, char) in input.enumerated() {
    if char.isNumber() {
      if curIndex == nil {
        curIndex = Int(String(i))
      }
      curNum.append(char.value)
    } else {
      if let curIndex {
        var newResult = PartNumber(
          startIndex: curIndex, endIndex: curIndex + curNum.count - 1, value: Int(curNum)!,
          line: line)
        if let lineAbove {
          newResult.appendAdjacent(line: lineAbove)
        }
        if let lineBelow {
          newResult.appendAdjacent(line: lineBelow)
        }
        result.append(newResult)
      }
      curNum = ""
      curIndex = nil
    }
  }
  return result
}

struct Gear {
  let index: Int
  let value: Int
  let line: Int
}
var answer1 = 0
var gears: [Gear] = []

for (offset, line) in lines.enumerated() {
  let lineAbove = offset > 0 ? Line(data: String(lines[offset - 1]), position: offset - 1) : nil
  let lineBelow =
    offset >= lines.count - 1 ? nil : Line(data: String(lines[offset + 1]), position: offset + 1)
  let partNums = extract(
    line: Line(data: String(line), position: offset), lineAbove: lineAbove, lineBelow: lineBelow)
  var sum = 0
  for partNum in partNums {
    if partNum.isValidPartNum() {
      sum += partNum.value
    }
    partNum.getGears().forEach {
      gears.append(Gear(index: $0.index, value: partNum.value, line: $0.line))
    }
  }
  answer1 += sum
}

var answer2 = 0
for gear in gears {
  for gear2 in gears {
    if gear.line == gear2.line && gear.index == gear2.index && gear.value != gear2.value {
      answer2 += gear.value * gear2.value
    }
  }
}

print(answer1, answer2 / 2)
