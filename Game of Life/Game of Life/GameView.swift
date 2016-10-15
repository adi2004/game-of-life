//
//  MainView.swift
//  Game of Life
//
//  Created by Adrian Florescu on 21.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameView: UIView {
    fileprivate var lastUpdatedPoint: Point = Point(x:0, y:0)
    
    // MARK: Public Variables
    let fSize: CGFloat = 10.0
    var game: Game
    
    // MARK: Constructors
    required init?(coder aDecoder: NSCoder) {
        game = Game()
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Cycle
    override func draw(_ rect: CGRect) {
        let drawFunction: (_:Point) -> () = drawSquareEntity
        for e in game.entities {
            drawFunction(e)
        }
    }
    
    // MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateEntity(touches)
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateEntity(touches)
        self.setNeedsDisplay()
    }
    
    // MARK: Helper Methods
    func drawEntity(_ e: Point) {
        let path = UIBezierPath(roundedRect: CGRect(x: CGFloat(e.x) * fSize, y: CGFloat(e.y) * fSize, width: fSize, height: fSize), cornerRadius: fSize / 10)
        UIColor.blue.setFill()
        path.fill()
    }
    
    func drawSquareEntity(_ e: Point) {
        let context = UIGraphicsGetCurrentContext()
        let spacing = fSize * 0.05
        let fX0 = CGFloat(e.x) * fSize + spacing
        let fY0 = CGFloat(e.y) * fSize + spacing
        let fXMax = CGFloat(e.x + 1) * fSize - spacing
        let fYMax = CGFloat(e.y + 1) * fSize - spacing
        context?.move   (to: CGPoint(x: fX0, y: fY0))
        context?.addLine(to: CGPoint(x: fX0, y: fYMax))
        context?.addLine(to: CGPoint(x: fXMax, y: fYMax))
        context?.addLine(to: CGPoint(x: fXMax, y: fY0))
        context?.addLine(to: CGPoint(x: fX0, y: fY0))
        context?.setFillColor(UIColor.red.cgColor)
        context?.fillPath()
    }
    
    func updateEntity(_ touches: Set<UITouch>) {
        for t in touches {
            let iX = Int(t.location(in: self).x / fSize)
            let iY = Int(t.location(in: self).y / fSize)
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
