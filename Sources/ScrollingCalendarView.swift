//
//  ScrollingCalendarView.swift
//  Optimal Health
//
//  Created by Daniel Pressner on 18.11.22.
//

import SwiftUI

@available(iOS 14, macOS 11.0, *)
public struct ScrollingCalendarView: View {
  
  @ObservedObject var vm: ScrollingCalendarViewModel
  
  public var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(vm.calendarBlocks, id:\.id) { block in
          CalendarCell(model: CalendarBlockModel(month: block.month, year: block.year), selectedDate: $vm.selectedDate)
            .onAppear { vm.loadMoreCalendarViews(item: block)}
            .padding(.vertical)
            Divider()
        }
      }
    }
  }
  
  public init(vm: ScrollingCalendarViewModel) {
    self.vm = vm
  }
}

@available(iOS 14, macOS 11.0, *)
struct ScrollingCalendarView_Previews: PreviewProvider {
  static var previews: some View {
    ScrollingCalendarView(vm: ScrollingCalendarViewModel())
  }
}
