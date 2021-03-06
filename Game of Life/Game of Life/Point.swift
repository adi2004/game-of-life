//
//  Point.swift
//  Game of Life
//
//  Created by Adrian Florescu on 22.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

open class Point: Hashable {
    var x: Int = 0
    var y: Int = 0
    open var hashValue: Int {
        get {
            return "\(x)\(y)".hashValue
        }
    }
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
