import SwiftUI

public struct ScrollingCalendar: View {
  
  @ObservedObject var viewModel: ScrollingCalendarViewModel
  @Binding var selectedDate: DateComponents?

  public var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(viewModel.calendarCells, id:\.id) { cell in
          CalendarCell(model: CalendarCellModel(month: cell.month, year: cell.year), selectedDate: $selectedDate)
            .onAppear {
              Task {
                try? await viewModel.loadNewCalendarCell(afterCurrentCell: cell)
              }
            }
            .padding(.vertical)
          Divider()
        }
      }
    }
    .task {
      guard viewModel.calendarCells.count == 0 else { return }
      await viewModel.createInitialCalendarCells()
    }
  }
  
  public init(viewModel: ScrollingCalendarViewModel, selectedDate: Binding<DateComponents?>) {
    self.viewModel = viewModel
    _selectedDate = selectedDate
  }
}

struct ScrollingCalendar_Previews: PreviewProvider {
  static var previews: some View {
    ScrollingCalendar(viewModel: ScrollingCalendarViewModel(interface: butt()), selectedDate: .constant(nil))
  }
}


