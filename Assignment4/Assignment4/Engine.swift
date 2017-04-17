

import Foundation

protocol EngineDelegate {

  func engineDidUpdate(withGrid: GridProtocol)
  
}

protocol EngineProtocol {

  init(_ rows: Int, _ cols: Int)

  var delegate : EngineDelegate? {get set}
  var grid : GridProtocol {get}
  var refreshRate : Double {get set}
  var refreshTimer : Timer? {get set}
  var rows: Int {get set}
  var cols: Int {get set}

  func step() -> GridProtocol
}

class StandardEngine : EngineProtocol {
  static var sharedInstance = StandardEngine(10, 10)
  var refreshRate: Double
  var refreshTimer: Timer?
  var delegate: EngineDelegate?
  var cols: Int
  var rows: Int
  var grid: GridProtocol

  required init(_ rows: Int, _ cols: Int) {
    self.rows = rows
    self.cols = cols
    self.grid = Grid(GridSize(rows: self.rows, cols:self.cols), cellInitializer: { _ in .empty })
    refreshRate = 0
    refreshTimer = nil

    let notification = NotificationCenter.default
    let name = Notification.Name(rawValue: "UpdateEngine")
    notification.addObserver(forName: name, object: nil, queue: nil) { notification in
      print("\(notification.name): \(notification.userInfo ?? [:])")
    }
  }

  func step() -> GridProtocol {
    return grid.next()
  }

}
