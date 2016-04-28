//
//  ViewController.swift
//  Game of Life
//
//  Created by Adrian Florescu on 20.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  @IBOutlet weak var vView: GameView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var slider: UISlider!
  var game: Game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
  var timer: NSTimer
  var bIsTimerStarted: Bool
  
  required init?(coder aDecoder: NSCoder) {
    timer = NSTimer.init()
    bIsTimerStarted = false
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    doRefresh(self)
  }
  
  @IBAction func doRefresh(sender: AnyObject) {
    game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
    updateVView(game)
  }
  
  @IBAction func doNext(sender: AnyObject) {
    game.next()
    updateVView(game)
  }
  
  @IBAction func doAnimate(sender: AnyObject) {
    let button = sender as! UIButton
    if bIsTimerStarted {
      button.setTitle("Start", forState: UIControlState.Normal)
      bIsTimerStarted = false
      timer.invalidate()
    } else {
      button.setTitle("Stop", forState: UIControlState.Normal)
      bIsTimerStarted = true
      updateTimer(getLogarithmicValue(slider.value))
    }
  }
  
  @IBAction func doValueChanged(sender: AnyObject) {
    if bIsTimerStarted {
      updateTimer(getLogarithmicValue(slider.value))
    }
  }
  
  func updateVView(g: Game) {
    lblTitle.text = "Generation \(g.generation). Living \(g.entities.count)"
    vView.game = g
    vView.setNeedsDisplay()
  }
  
  func updateTimer(fValue: Double) {
    timer.invalidate()
    timer = NSTimer.scheduledTimerWithTimeInterval(fValue, target: self, selector: #selector(doNext), userInfo: nil, repeats: true)
  }
  
  func getLogarithmicValue(fValue:Float) -> Double {
    let max = 5.0
    let out = (exp(Double(fValue) * max) - 1.0) / exp(max)
    return round(out * 1000)/1000
  }
}

