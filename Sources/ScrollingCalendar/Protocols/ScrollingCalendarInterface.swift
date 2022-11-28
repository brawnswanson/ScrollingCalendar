//
//  File.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import Foundation

public protocol ScrollingCalendarInterface {
  func getFilledInDaysFor(month: Int, and year: Int) -> [Int]
}

class butt: ScrollingCalendarInterface {
  func getFilledInDaysFor(month: Int, and year: Int) -> [Int] {
    return []
  }
}
