//
//  GridView.swift
//  Assignment3
//
//  Created by Dewar Tan on 3/25/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

  @IBInspectable var size: Int = 20 {
    didSet {
      grid = Grid(size, size)
    }
  }
  @IBInspectable var livingColor: UIColor = UIColor.green
  @IBInspectable var emptyColor: UIColor = UIColor.black
  @IBInspectable var bornColor: UIColor = UIColor.cyan
  @IBInspectable var diedColor: UIColor = UIColor.red
  @IBInspectable var gridColor: UIColor = UIColor.orange
  @IBInspectable var gridWidth: CGFloat = 0.0
  var grid = Grid(3,3)
  var lastTouchedPosition: Position?


  override func draw(_ rect: CGRect) {

    let splitRectSize = CGSize(width: rect.size.width/CGFloat(size), height: rect.size.height/CGFloat(size))

    //Draw the Grid
    (0 ..< size+1).forEach {
      var start = CGPoint(x: 0.0, y: splitRectSize.height * CGFloat($0))
      var end = CGPoint(x: rect.size.width, y: splitRectSize.height * CGFloat($0))
      drawLines(start, end)

      start = CGPoint(x: splitRectSize.width * CGFloat($0), y: 0.0)
      end = CGPoint(x:splitRectSize.width * CGFloat($0), y: rect.size.height)
      drawLines(start, end)
    }


    let rectOrigin = rect.origin
    (0 ..< size+1).forEach { i in
      (0 ..< size+1).forEach { j in

        let origin = CGPoint(
          x: rectOrigin.x + (CGFloat(j) * splitRectSize.width),
          y: rectOrigin.y + (CGFloat(i) * splitRectSize.height)
        )

        let subRect = CGRect(
          origin: origin,
          size: splitRectSize
        )
        fillCircleColor(subRect, grid[Position(row: i, col: j)])
      }
    }
  }

  //Fills the color of each circle
  func fillCircleColor(_ subRect: CGRect, _ cellState: CellState) {
    let path = UIBezierPath(ovalIn: subRect)
    switch cellState {
    case .alive:
      livingColor.setFill()
    case .born:
      bornColor.setFill()
    case .died:
      diedColor.setFill()
    case .empty:
      emptyColor.setFill()
    }
    path.fill()
  }

  func drawLines(_ start: CGPoint, _ end: CGPoint) {
    let gridLine = UIBezierPath()
    gridLine.lineWidth = gridWidth
    gridLine.move(to: start)
    gridLine.addLine(to: end)
    gridColor.setStroke()
    gridLine.stroke()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastTouchedPosition = processTouch(touches: touches)
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastTouchedPosition = processTouch(touches: touches)
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastTouchedPosition = nil
  }


  func processTouch(touches: Set<UITouch>) -> Position? {
    guard touches.count == 1 else { return nil }
    let pos = convertToPosition(touch: touches.first!)
    guard lastTouchedPosition?.row != pos.row || lastTouchedPosition?.col != pos.col
      else { return pos }

    grid[pos] = grid[pos].isAlive ? .empty : .alive
    setNeedsDisplay()
    return pos
  }

  func convertToPosition(touch: UITouch) -> Position {
    let touchY = touch.location(in: self).y
    let gridHeight = bounds.size.height
    let row = touchY / gridHeight * CGFloat(size)
    let touchX = touch.location(in: self).x
    let gridWidth = bounds.size.width
    let col = touchX / gridWidth * CGFloat(size)
    let position = (row: Int(row), col: Int(col))
    return position
  }
  
  
  
}
