//
//  File.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import Foundation

struct CalendarColumnModel: Identifiable {
  let dayOfWeek: Int
  var dates: [CalendarDayModel] = []
  var id = UUID()
  
  mutating func addToDates(dayNumber: Int?, filled: Bool?) {
    let newDateToAdd = CalendarDayModel(day: dayNumber, filled: filled)
    dates.append(newDateToAdd)
  }
}
