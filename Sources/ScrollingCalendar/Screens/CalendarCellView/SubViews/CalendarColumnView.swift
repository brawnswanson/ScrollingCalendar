//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import SwiftUI

struct CalendarColumnView: View {
  
  let column: CalendarColumnModel
  @Binding var selectedDay: Int?
  
  var body: some View {
    VStack {
      ForEach(column.dates, id:\.id) { day in
        CalendarDayView(model: day, selectedDay: $selectedDay)
      }
    }
  }
}
