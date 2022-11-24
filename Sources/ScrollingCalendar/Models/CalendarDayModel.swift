//
//  CalendarDayModel.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 20.11.22.
//

import Foundation

public struct CalendarDayModel {
  public let id = UUID()
  let day: Int?
  let attachment: (any Equatable)?
}

//MARK: - setup functions
extension CalendarDayModel {
}

//MARK: - Computed variables for display
extension CalendarDayModel {
  
  var text: String {
    if let dayInput = day {
      return "\(dayInput)"
    } else {
      return ""
    }
  }
  
  var filled: Bool {
    if let _ = attachment { return true }
    else { return false }
  }
  
}
