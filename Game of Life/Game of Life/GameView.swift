//
//  MainView.swift
//  Game of Life
//
//  Created by Adrian Florescu on 21.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameView: UIView {
  private var lastUpdatedPoint: Point?
  let size: CGFloat = 10.0
  var game: Game?

  // MARK: Life Cycle
  override func drawRect(rect: CGRect) {
    if let gU = game {
      for e in gU.entities {
        //drawEntity(e)
        drawSquareEntity(e)
      }
    }
  }

  // MARK: Touches
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    updateEntity(touches)
    self.setNeedsDisplay()
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    updateEntity(touches)
    self.setNeedsDisplay()
  }

//  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//    updateEntity(touches)
//    self.setNeedsDisplay()
//  }

  func drawEntity(e: Point) {
    let path = UIBezierPath(roundedRect: CGRectMake(CGFloat(e.x) * size, CGFloat(e.y) * size, size, size), cornerRadius: size / 10)
    UIColor.blueColor().setFill()
    path.fill()
  }
  
  func drawSquareEntity(e: Point) {
    let context = UIGraphicsGetCurrentContext()
    let spaceing = size * 0.05
    CGContextMoveToPoint   (context, CGFloat(e.x)     * size + spaceing, CGFloat(e.y)     * size + spaceing)
    CGContextAddLineToPoint(context, CGFloat(e.x)     * size + spaceing, CGFloat(e.y + 1) * size - spaceing)
    CGContextAddLineToPoint(context, CGFloat(e.x + 1) * size - spaceing, CGFloat(e.y + 1) * size - spaceing)
    CGContextAddLineToPoint(context, CGFloat(e.x + 1) * size - spaceing, CGFloat(e.y)     * size + spaceing)
    CGContextAddLineToPoint(context, CGFloat(e.x)     * size + spaceing, CGFloat(e.y)     * size + spaceing)
    CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
    CGContextFillPath(context)

//    let context = UIGraphicsGetCurrentContext()
//    CGContextSetLineWidth(context, 4.0)
//    CGContextSetFillColor(context, UIColor.blueColor().CGColor)
//    //CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
//    let rectangle = CGRectMake(60,170,200,80)
//    CGContextAddRect(context, rectangle)
//    CGContextStrokePath(context)
//    let path = CGRectMake(CGFloat(e.x) * size, CGFloat(e.y) * size, size, size)
//    UIColor.blueColor().setFill()
//    path.fill()
  }

  func updateEntity(touches: Set<UITouch>) {
    for t in touches {
      let x = Int(t.locationInView(self).x / size)
      let y = Int(t.locationInView(self).y / size)
      let p = Point(x: x, y: y)
      let gameU = game!
//      if let lastUpdatedPointU = lastUpdatedPoint! {
        if gameU.entities.contains(p) {
          gameU.entities.remove(p)
        } else {
          gameU.entities.insert(p)
        }
//      }
    }
  }
}
