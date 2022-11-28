//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import SwiftUI

struct CalendarDayView: View {
  
  let model: CalendarDayModel
  @Binding var selectedDay: Int?
  
  var body: some View {
    Button {
      selectedDay = model.day
    } label: {
      DayButtonLabel(text: model.description, isFilled: model.shouldFill)
    }
  }
}

struct CalendarDayView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarDayView(model: CalendarDayModel(day: 1, filled: true), selectedDay: .constant(1))
  }
}
