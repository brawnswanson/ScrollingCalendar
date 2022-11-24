//
//  CalendarColumnModel.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 20.11.22.
//

import Foundation

public struct CalendarColumnModel: Identifiable {
  let dayOfWeek: Int
  var data: [CalendarDayModel] = []
  public var id = UUID()
  
  mutating func addToData(item: Int?, attachment: (any Equatable)?) {
    if let day = item {
      let calendarDay = CalendarDayModel(day: day, attachment: attachment)
      data.append(calendarDay)
    } else {
      data.append(CalendarDayModel(day: nil, attachment: nil))
    }
  }
}
