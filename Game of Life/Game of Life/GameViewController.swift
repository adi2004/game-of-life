//
//  ViewController.swift
//  Game of Life
//
//  Created by Adrian Florescu on 20.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit
import CircleMenu

class GameViewController: UIViewController {
    @IBOutlet weak var vView: GameView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var button: CircleMenu!
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
        
        self.addParallaxToView(vView, intensity: 25)
        doRefresh(self)
        button.delegate = self
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
    
    func addParallaxToView(view:UIView, intensity:CGFloat) {
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -intensity
        verticalMotionEffect.maximumRelativeValue = intensity
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -intensity
        horizontalMotionEffect.maximumRelativeValue = intensity
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        view.addMotionEffect(group)
    }
}

extension GameViewController: CircleMenuDelegate {
    // configure buttons
    func circleMenu(circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.setImage(UIImage(imageLiteral: "menu-icon"), forState: .Normal)
        button.backgroundColor = UIColor.yellowColor()
        button.tintColor = UIColor.redColor()
    }
    
    // call before animation
//    optional func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int)
    
    // call after animation
//    optional func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int)
}

