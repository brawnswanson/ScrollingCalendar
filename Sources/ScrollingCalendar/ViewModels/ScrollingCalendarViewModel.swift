//
//  ScrollingCalendarViewModel.swift
//  ScrollingCalendar
//
//  Created by Daniel Pressner on 20.11.22.
//

import Foundation

@available(iOS 14, macOS 11.0, *)
public class ScrollingCalendarViewModel: ObservableObject {
  
  @Published var sortedCalendarBlocks: [CalendarBlockModel] = []
  @Published private var calendarBlocks: [CalendarBlockModel] = []
  
  var dataSource: ScrollingCalendarDataSource?
  
  private var inSetupPhase = true
  
  public init(dataSource: ScrollingCalendarDataSource?) {
    self.dataSource = dataSource
    calendarBlocks = loadInitialCalendarItems()
    $calendarBlocks
      .map { $0.sorted { month1, month2 in
        let date1 = Calendar.current.date(from: DateComponents(calendar: Calendar.current, year: month1.year, month: month1.month))!
        let date2 = Calendar.current.date(from: DateComponents(calendar: Calendar.current, year: month2.year, month: month2.month))!
        return date1 > date2
      }}
      .assign(to: &$sortedCalendarBlocks)
  }
  
  func loadInitialCalendarItems() -> [CalendarBlockModel] {
    var result = [CalendarBlockModel]()
    
    let calendar = Calendar.current
    for i in stride(from: 0, to: -4, by: -1) {
      if let newMonth = calendar.date(byAdding: .month, value: i, to: Date()) {
        let newMonthComponents = calendar.dateComponents([.year, .month], from: newMonth)
        result.append(CalendarBlockModel(month: newMonthComponents.month!, year: newMonthComponents.year!, attachmentData: dataSource?.attachmentData))
      }
    }
    inSetupPhase = false
    return result
  }
  
  func loadMoreCalendarViews(item: CalendarBlockModel) {
    guard inSetupPhase == false, let lastMonth = sortedCalendarBlocks.last else { return }
    if item.id == lastMonth.id {
      let dateComponents = DateComponents(calendar: Calendar.current, year: lastMonth.year, month: lastMonth.month)
      guard let newDate = Calendar.current.date(from: dateComponents), let newComps = Calendar.current.date(byAdding: .month, value: -1, to: newDate) else { return }
      let comps = Calendar.current.dateComponents([.year, .month], from: newComps)
      let newMonth = CalendarBlockModel(month: comps.month!, year: comps.year!, attachmentData: dataSource?.attachmentData)
      calendarBlocks.append(newMonth)
    }
  }
}
