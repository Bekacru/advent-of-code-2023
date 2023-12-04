import Foundation

let input = try! String(contentsOf: URL(filePath: "./inputs/input-4.txt"), encoding: .utf8)

var result = 0
var cardInstances: [Int] = []

for (offset, line) in input.split(separator: "\n").enumerated() {
  let parts = line.split(separator: ":")[1].split(separator: "|")
  let card = parts[0].split(separator: " ").compactMap { Int($0) }
  let possibleWinningNumbers = parts[1].split(separator: " ").compactMap {
    Int($0)
  }
  let winningNumbers = Set(card).intersection(possibleWinningNumbers)
  var sum = 0
  let cardNo = offset + 1
  var cardWins: [Int] = [cardNo]
  let copy = cardInstances.filter { $0 == cardNo }.count + 1
  for (index, _) in winningNumbers.enumerated() {
    if index == 0 {
      sum += 1
    } else {
      sum = sum * 2
    }
    let winCopy = cardNo + index + 1
    cardWins += Array(repeating: winCopy, count: copy)
  }
  result += sum
  cardInstances += cardWins

}

var numberCounts: [Int: Int] = [:]

for number in cardInstances {
  numberCounts[number, default: 0] += 1
}

print(result, numberCounts.values.reduce(0, +))
