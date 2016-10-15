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
    let entitySize: CGFloat = 10.0
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
        let path = UIBezierPath(roundedRect: CGRect(x: CGFloat(e.x) * entitySize, y: CGFloat(e.y) * entitySize, width: entitySize, height: entitySize), cornerRadius: entitySize / 10)
        UIColor.blue.setFill()
        path.fill()
    }
    
    func drawSquareEntity(_ e: Point) {
        let context = UIGraphicsGetCurrentContext()
        let spacing = entitySize * 0.05
        let x0 = CGFloat(e.x) * entitySize + spacing
        let y0 = CGFloat(e.y) * entitySize + spacing
        let xMax = CGFloat(e.x + 1) * entitySize - spacing
        let yMax = CGFloat(e.y + 1) * entitySize - spacing
        context?.move   (to: CGPoint(x: x0, y: y0))
        context?.addLine(to: CGPoint(x: x0, y: yMax))
        context?.addLine(to: CGPoint(x: xMax, y: yMax))
        context?.addLine(to: CGPoint(x: xMax, y: y0))
        context?.addLine(to: CGPoint(x: x0, y: y0))
        context?.setFillColor(UIColor.red.cgColor)
        context?.fillPath()
    }
    
    func updateEntity(_ touches: Set<UITouch>) {
        for t in touches {
            let x = Int(t.location(in: self).x / entitySize)
            let y = Int(t.location(in: self).y / entitySize)
            let point = Point(x: x, y: y)
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
