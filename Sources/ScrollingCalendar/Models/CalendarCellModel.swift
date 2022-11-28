//
//  File.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import Foundation

struct CalendarCellModel: Identifiable {
  let cal = Calendar.current
  let month: Int
  let year: Int
  let markedData: [Int]
  let id = UUID()
  var calendarColumns: [CalendarColumnModel] = []
  
  var title: String {
    "\(cal.shortStandaloneMonthSymbols[month-1]) \(firstDayOfMonthComponents.year!)"
  }
  
  init(month: Int, year: Int, markedData: [Int] = []) {
    self.month = month
    self.year = year
    self.markedData = markedData
    self.calendarColumns = setUpDayOfWeekColumns()
    setFirstDayOfMonth()
    fillInDaysUpToLastDayOfMonth()
    fillInEmptyDaysInWeek()
  }
}

//MARK: - Calendar setup functions
extension CalendarCellModel {
  
  func setUpDayOfWeekColumns() -> [CalendarColumnModel] {
    var columnsArray: [CalendarColumnModel] = []
    for i in 1..<8 {
      let newColumn = CalendarColumnModel(dayOfWeek: i)
      columnsArray.append(newColumn)
    }
    return columnsArray
  }
  
  mutating func setFirstDayOfMonth() {
      for i in 0..<firstDayOfMonthDayIndex {
        calendarColumns[i].addToDates(dayNumber: nil, filled: nil)
      }
      let isFilled = isFilled(day: 1)
      calendarColumns[firstDayOfMonthDayIndex].addToDates(dayNumber: 1, filled: isFilled)
  }
  
  mutating func fillInDaysUpToLastDayOfMonth() {
    let lastDayOfMonth = daysInMonth.last!
    var currentWeekdayColumn = firstDayOfMonthDayIndex + 1
    for i in 2...lastDayOfMonth {
      currentWeekdayColumn = currentWeekdayColumn == 7 ? 0 : currentWeekdayColumn
      let isFilled = isFilled(day: i)
      calendarColumns[currentWeekdayColumn].addToDates(dayNumber: i, filled: isFilled)
      currentWeekdayColumn += 1
    }
  }
  
  mutating func fillInEmptyDaysInWeek() {
    var columnLengths: [Int] = []
    for column in calendarColumns {
      columnLengths.append(column.dates.count)
    }
    let maxColumnLength = columnLengths.max()!
    let unfilledColumns = calendarColumns.filter { column in
      column.dates.count < maxColumnLength
    }
    for unfilledColumn in unfilledColumns {
      let index = unfilledColumn.dayOfWeek - 1
      calendarColumns[index].addToDates(dayNumber: nil, filled: nil)
    }
  }
  
  func isFilled(day: Int) -> Bool {
    guard let _ = markedData.first(where: { possibleDay in
      possibleDay == day
    }) else { return false }
    return true
  }
}

//MARK: - reused calculated variables
extension CalendarCellModel {
  var firstDayOfMonthComponents: DateComponents {
    DateComponents(calendar: cal, year: year, month: month, day: 1)
  }
  
  var firstDayOfMonth: Date {
    cal.date(from: firstDayOfMonthComponents)!
  }
  
  var daysInMonth: Range<Int> {
    cal.range(of: .day, in: .month, for: firstDayOfMonth)!
  }
  
  var firstDayOfMonthDayIndex: Int {
    cal.dateComponents([.weekday], from: firstDayOfMonth).weekday! - 1
  }
}
