//
//  Game.swift
//  Game of Life
//
//  Created by Adrian Florescu on 22.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class Game: NSObject {
    var entities = Set<Point>()
    
    init(nrOfEntities nr:Int, x:UInt32, y:UInt32) {
        for _ in 0..<nr {
            entities.insert(Point(x: Int(arc4random_uniform(x)), y: Int(arc4random_uniform(y))))
        }
    }
}
