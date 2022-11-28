//
//  File.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import Foundation

struct CalendarDayModel: Identifiable {
  let id = UUID()
  let day: Int?
  let filled: Bool?
  
  var shouldFill: Bool {
    guard let filled = filled, filled == true else { return false}
    return true
  }
}

extension CalendarDayModel: CustomStringConvertible {
  var description: String {
    guard let day = day else { return "" }
    return "\(day)"
  }
}
