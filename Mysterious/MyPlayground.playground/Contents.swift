import UIKit

let startDate = "2017-09-24"
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
let formatedStartDate = dateFormatter.date(from: startDate)

let secondDate = "2019-09-24"
let formatedSecondDate = dateFormatter.date(from: secondDate)

let currentDate = Date()
let components = Set<Calendar.Component>([.day, .month, .year])
let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: formatedSecondDate!)

print(differenceOfDate)

print("year: \(differenceOfDate.year!), month: \(differenceOfDate.month!), day: \(differenceOfDate.day!)")
