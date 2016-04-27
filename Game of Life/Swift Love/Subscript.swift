//
//  Subscript.swift
//  Game of Life
//
//  Created by Adrian Florescu on 27.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import Foundation


class Subscript {
  // play with subscript
  struct Colors {
    let iBlack: Int
    var iDefault: Int
    subscript(strColor: String) -> Int {
      get {
        if strColor == "Black" {
          return iBlack
        } else {
          return iDefault
        }
      }
      
      set {
        iDefault = newValue
      }
    }
  }
  
  class func run() {
    var color: Colors = Colors(iBlack: 0, iDefault: 1)
    
    print("Hello, World of Subscript!")
    color["Black"] = 3
    print("Value for black is \(color["Black"])")
    print("Value for default is \(color["...aksf..."])")
  }

}