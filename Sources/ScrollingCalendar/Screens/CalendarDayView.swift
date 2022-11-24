//
//  CalendarDayView.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 20.11.22.
//

import SwiftUI

@available(iOS 14, macOS 11.0, *)
struct CalendarDayView: View {
  
  let model: CalendarDayModel
  
  var body: some View {
    ZStack {
      Text(model.text)
      Circle()
        .stroke(lineWidth: 2.0)
        .foregroundColor(.blue)
        .opacity(model.filled ? 1.0 : 0.0)
    }
    .frame(width: 40.0)
    
  }
}

@available(iOS 14, macOS 11.0, *)
struct CalendarDayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDayView(model: CalendarDayModel(day: 1, attachment: UUID()))
    }
}
