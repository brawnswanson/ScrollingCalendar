//
//  CalendarBlockModel.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 20.11.22.
//

import Foundation

@available(iOS 14, macOS 11.0, *)
public struct CalendarBlockModel: Identifiable {
  let cal = Calendar.current
  let month: Int
  let year: Int
  let attachmentData: [any ScrollingCalendarAttachment]
  public let id = UUID()
  var calendarColumns: [CalendarColumnModel] = []
  
  var title: String {
    "\(cal.shortStandaloneMonthSymbols[month-1]) \(firstDayOfMonthComponents.year!)"
  }
  
  public init(month: Int, year: Int, attachmentData: [any ScrollingCalendarAttachment]?) {
    self.month = month
    self.year = year
    if let attachmentArray = attachmentData {
      self.attachmentData = attachmentArray
    } else {
      self.attachmentData = []
    }
    
    self.calendarColumns = setUpDayOfWeekColumns()
    setFirstDayOfMonth()
    fillInDaysUpToLastDayOfMonth()
    fillInEmptyDaysInWeek()
  }
}

//MARK: - Calendar setup functions
@available(iOS 14, macOS 11.0, *)
extension CalendarBlockModel {
  
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
        calendarColumns[i].addToData(item: nil, attachment: nil)
      }
      calendarColumns[firstDayOfMonthDayIndex].addToData(item: 1, attachment: getAttachmentFor(day: 1))
  }
  
  mutating func fillInDaysUpToLastDayOfMonth() {
    let lastDayOfMonth = daysInMonth.last!
    var currentWeekdayColumn = firstDayOfMonthDayIndex + 1
    for i in 2...lastDayOfMonth {
      currentWeekdayColumn = currentWeekdayColumn == 7 ? 0 : currentWeekdayColumn
      calendarColumns[currentWeekdayColumn].addToData(item: i, attachment: getAttachmentFor(day: i))
      currentWeekdayColumn += 1
    }
  }
  
  mutating func fillInEmptyDaysInWeek() {
    var columnLengths: [Int] = []
    for column in calendarColumns {
      columnLengths.append(column.data.count)
    }
    let maxColumnLength = columnLengths.max()!
    let unfilledColumns = calendarColumns.filter { column in
      column.data.count < maxColumnLength
    }
    for unfilledColumn in unfilledColumns {
      let index = unfilledColumn.dayOfWeek - 1
      calendarColumns[index].data.append(CalendarDayModel(day: nil, attachment: nil))
    }
  }
  
  func getAttachmentFor(day: Int) -> (any ScrollingCalendarAttachment)? {
    attachmentData.first { item in
      item.month == self.month && item.year == self.year && item.day == day
    }
  }
}

//MARK: - reused calculated variables

@available(iOS 14, macOS 11.0, *)
extension CalendarBlockModel {
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
