//
//  q.swift
//  Game of Life
//
//  Created by Adrian Florescu on 28.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import Foundation


class SurveyQuestion {
  var text: String
  var response: String?
  
  init(text: String) {
    self.text = text
  }
  
  func ask() {
    print(text)
  }
  
  func run() {
    //let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
    let a = 2
    let b = 3
    if let x:Int = a + b where x < 15 {
      self.ask()
    }
  }
}
