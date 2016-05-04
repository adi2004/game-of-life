//
//  MainView.swift
//  Game of Life
//
//  Created by Adrian Florescu on 21.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameView: UIView {
    private var lastUpdatedPoint: Point = Point(x:0, y:0)
    
    // MARK: Public Variables
    let fSize: CGFloat = 10.0
    var game: Game
    
    // MARK: Constructors
    required init?(coder aDecoder: NSCoder) {
        game = Game()
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Cycle
    override func drawRect(rect: CGRect) {
        let drawFunction: (_:Point) -> () = drawSquareEntity
        for e in game.entities {
            drawFunction(e)
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
    
    // MARK: Helper Methods
    func drawEntity(e: Point) {
        let path = UIBezierPath(roundedRect: CGRectMake(CGFloat(e.x) * fSize, CGFloat(e.y) * fSize, fSize, fSize), cornerRadius: fSize / 10)
        UIColor.blueColor().setFill()
        path.fill()
    }
    
    func drawSquareEntity(e: Point) {
        let context = UIGraphicsGetCurrentContext()
        let spacing = fSize * 0.05
        let fX0 = CGFloat(e.x) * fSize + spacing
        let fY0 = CGFloat(e.y) * fSize + spacing
        let fXMax = CGFloat(e.x + 1) * fSize - spacing
        let fYMax = CGFloat(e.y + 1) * fSize - spacing
        CGContextMoveToPoint   (context, fX0,   fY0)
        CGContextAddLineToPoint(context, fX0,   fYMax)
        CGContextAddLineToPoint(context, fXMax, fYMax)
        CGContextAddLineToPoint(context, fXMax, fY0)
        CGContextAddLineToPoint(context, fX0,   fY0)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillPath(context)
    }
    
    func updateEntity(touches: Set<UITouch>) {
        for t in touches {
            let iX = Int(t.locationInView(self).x / fSize)
            let iY = Int(t.locationInView(self).y / fSize)
            let point = Point(x: iX, y: iY)
            if point != lastUpdatedPoint {
                lastUpdatedPoint = point
                if game.entities.contains(point) {
                    game.entities.remove(point)
                } else {
                    game.entities.insert(point)
                }
            }
        }
    }
    
}
