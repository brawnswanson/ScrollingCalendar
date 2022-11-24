//
//  ScrollingCalendarLogDataProtocol.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 21.11.22.
//

import Foundation
import SwiftUI

@available(iOS 14, macOS 11.0, *)
public protocol ScrollingCalendarDataSource {
  var attachmentData: [any ScrollingCalendarAttachment] {get}
}

@available(iOS 14, macOS 11.0, *)
public protocol ScrollingCalendarAttachment: Equatable {
  var month: Int {get}
  var year: Int {get}
  var day: Int {get}
  var attachment: (any Equatable)? {get}
  var navigationDestination: (any View)? {get}
}
