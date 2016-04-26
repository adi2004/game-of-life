//
//  MainView.swift
//  Game of Life
//
//  Created by Adrian Florescu on 21.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameView: UIView {
  let size: CGFloat = 10.0
  var game: Game?

  // MARK: Life Cycle
  override func drawRect(rect: CGRect) {
    if let gU = game {
      for e in gU.entities {
        drawEntity(e)
      }
    } else {
      let x = self.bounds.width / 2 - size / 2
      let y = self.bounds.height / 2 - size / 2
      let path = UIBezierPath(roundedRect: CGRectMake(x, y, size, size), cornerRadius: size / 10)
      UIColor.blueColor().setFill()
      path.fill()
      drawEntity(Point(x: 0, y: 0))
      drawEntity(Point(x: 2, y: 2))
    }
  }

  // MARK: Touches
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    insertEntity(touches)
    self.setNeedsDisplay()
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    insertEntity(touches)
    self.setNeedsDisplay()
  }

  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    insertEntity(touches)
    self.setNeedsDisplay()
  }

  func drawEntity(e: Point) {
    let path = UIBezierPath(roundedRect: CGRectMake(CGFloat(e.x) * size, CGFloat(e.y) * size, size, size), cornerRadius: size / 10)
    UIColor.blueColor().setFill()
    path.fill()
  }

  func insertEntity(touches: Set<UITouch>) {
    for t in touches {
      game?.entities.insert(Point(x: Int(t.locationInView(self).x / size), y: Int(t.locationInView(self).y / size)))
    }
  }
}
