//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import SwiftUI

struct CalendarCellDaysOfWeekStack: View {
  
  let columns: [CalendarColumnModel]
  @Binding var selectedDay: Int?
  
  var body: some View {
    HStack {
      ForEach(columns, id:\.id) { column in
        CalendarColumnView(column: column, selectedDay: $selectedDay)
      }
    }
  }
}
