//
//  MainView.swift
//  Game of Life
//
//  Created by Adrian Florescu on 21.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameView: UIView {
    let size:CGFloat = 50.0
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let x = self.bounds.width / 2 - size / 2
        let y = self.bounds.height / 2 - size / 2
        let path = UIBezierPath(roundedRect: CGRectMake(x, y, size, size), cornerRadius: size/10)
        UIColor.blueColor().setFill()
        path.fill()
//        let bounds = self.bounds
//        let radius = min(bounds.width, bounds.height) / 2
//        CGPoint(x: bounds.width / 2, y: bounds.height / 2)
//        let path = UIBezierPath()
    }

}
