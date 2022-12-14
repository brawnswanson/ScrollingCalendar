//
//  File.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import Foundation

public class ScrollingCalendarViewModel: ObservableObject {
  
  var interface: ScrollingCalendarInterface
  
  @Published var calendarCells: [CalendarCellModel] = []
  @Published var calendarType: CalendarType
  
  let cal = Calendar.current
  
  public init(interface: ScrollingCalendarInterface, calendarType: CalendarType = .fixedLength(months: 12)) {
    self.interface = interface
    self.calendarType = calendarType
  }
}

//MARK: - Calendar cell creation functions
extension ScrollingCalendarViewModel {
  func loadNewCalendarCell(afterCurrentCell cell: CalendarCellModel) async throws {
    if calendarType != .variableLength { return }
    let currentCell = try await checkIfIsLast(cell: cell)
    let dateOfCurrentCell = try await getDateOf(cell: currentCell)
    let newCell = try await getCalendarCellByAdding(months: -1, to: dateOfCurrentCell)
    await addCalendarCellToModel(newCell)
  }
  
  func checkIfIsLast(cell: CalendarCellModel) async throws -> CalendarCellModel {
    guard let lastCell = calendarCells.last, lastCell.id == cell.id else { throw CalendarError.notLastCell }
    return cell
  }
  
  func getDateOf(cell: CalendarCellModel) async throws -> Date {
    let cellDateComponents = DateComponents(calendar: cal, year: cell.year, month: cell.month)
    guard let dateOfCell = cal.date(from: cellDateComponents) else { throw CalendarError.dateComponentConversionError }
    return dateOfCell
  }
  
  func createInitialCalendarCells() async {
    var startingMonthOffset:Int
    switch calendarType {
    case .fixedLength(let months):
      startingMonthOffset = -months
    default:
      startingMonthOffset = -12
    }
    for i in startingMonthOffset..<1 {
      if let cell = try? await getCalendarCellByAdding(months: i, to: Date()) {
        await addCalendarCellToModel(cell)
      }
    }
  }
  
  func getCalendarCellByAdding(months: Int, to date: Date) async throws -> CalendarCellModel {
    guard let adjustedDate = cal.date(byAdding: .month, value: months, to: date) else { throw CalendarError.invalidDate }
    let adjustedComponents = cal.dateComponents([.month, .year], from: adjustedDate)
    guard let monthIndex = adjustedComponents.month, let yearIndex = adjustedComponents.year else { throw CalendarError.dateComponentConversionError }
    //TODO: Here add getting array of filled days. Need to add handling of this array in the cellmodel
    return CalendarCellModel(month: monthIndex, year: yearIndex)
  }
  
  @MainActor
  func addCalendarCellToModel(_ cell: CalendarCellModel) async {
    calendarCells.append(cell)
  }
}

//MARK: - Computed variables to compliment functions
extension ScrollingCalendarViewModel {
  var firstMonthComponents: DateComponents {
    cal.dateComponents([.month, .year], from: Date())
  }
}

//MARK: - Internal errors
extension ScrollingCalendarViewModel {
  enum CalendarError: Error {
    case invalidDate
    case dateComponentConversionError
    case noCurrentCells
    case notLastCell
  }
}

public enum CalendarType: Equatable {
  case fixedLength(months: Int = 12)
  case variableLength
  
  public static func == (lhs: CalendarType, rhs: CalendarType) -> Bool {
    switch (lhs, rhs) {
    case (.fixedLength, .fixedLength):
      return true
    case (.variableLength, .variableLength):
      return true
    default:
      return false
    }
  }
}
