//
//  CalendarCell.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 18.11.22.
//

import SwiftUI

@available(iOS 14, macOS 11.0, *)
struct CalendarCell: View {
  
  let model: CalendarBlockModel
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text(model.title)
          .padding(.horizontal)
        Spacer()
      }
      HStack {
        ForEach(model.calendarColumns, id:\.id) { column in
          VStack {
            ForEach(column.data, id:\.id) { day in
              CalendarDayView(model: day)
            }
          }
        }
      }
    }
  }
}

@available(iOS 14, macOS 11.0, *)
struct CalendarCell_Previews: PreviewProvider {
  static var previews: some View {
    CalendarCell(model: CalendarBlockModel(month: 11, year: 2022, attachmentData: nil))
  }
}


