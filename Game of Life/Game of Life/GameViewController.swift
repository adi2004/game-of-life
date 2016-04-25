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
    var g:Game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
    var timer:NSTimer?
    var currentTimerValue:Int = 0
    let timerValues:[Double] = [Double.infinity, 1000, 300, 100, 50, 10, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doRefresh(self)
        timer = NSTimer.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doRefresh(sender: AnyObject) {
      g = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
      updateVView(g)
    }
    
    @IBAction func doNext(sender: AnyObject) {
      g.next()
      updateVView(g)
    }

    @IBAction func doAnimate(sender: AnyObject) {
      currentTimerValue = (currentTimerValue + 1) % timerValues.count
      timer?.invalidate()
      timer = NSTimer.scheduledTimerWithTimeInterval(timerValues[currentTimerValue]/1000, target: self, selector: #selector(doNext), userInfo: nil, repeats: true)
      (sender as! UIButton).setTitle("Next gen in \(timerValues[currentTimerValue]) ms", forState: UIControlState.Normal)
    }
  
  func updateVView(g:Game) {
    lblTitle.text = "Generation \(g.generation). Living \(g.entities.count)"
    vView.game = g
    vView.setNeedsDisplay()
  }
  
}

