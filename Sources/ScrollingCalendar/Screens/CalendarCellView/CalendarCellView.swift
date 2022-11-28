//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//
import SwiftUI

struct CalendarCell: View {
  
  let model: CalendarCellModel
  @State var selectedDay: Int?
  
  @Binding var selectedDate: DateComponents?
  
  var body: some View {
    VStack(spacing: 0) {
      CalendarCellTitle(text: model.title)
      CalendarCellDaysOfWeekStack(columns: model.calendarColumns, selectedDay: $selectedDay)
    }
    .onChange(of: selectedDay) { day in
      guard let day = day else { return }
      let newDate = DateComponents(calendar: Calendar.current, year: model.year, month: model.month, day: day)
      _selectedDate.wrappedValue = newDate
    }
  }
}

struct CalendarCell_Previews: PreviewProvider {
  static var previews: some View {
    CalendarCell(model: CalendarCellModel(month: 11, year: 2022), selectedDate: .constant(Calendar.current.dateComponents([.month, .day, .year], from: Date())))
  }
}
