//
//  GameTextView.swift
//  Game of Life
//
//  Created by Adrian Florescu on 22.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameTextView: NSObject {
  class func getText(game g: Game, x: Int, y: Int, rows: Int, cols: Int) -> String {
    var s: String = ""
    for i in x ..< x + rows {
      for j in y ..< y + cols {
        if g.entities.contains(Point(x: i, y: j)) {
          s += "*"
        } else {
          s += "."
        }
      }
      s += "\n"
    }

    return s
  }
}
