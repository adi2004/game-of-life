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
    @IBOutlet weak var button: UIButton!
    var game: Game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
    var timer: Timer
    var bIsTimerStarted: Bool
    
    required init?(coder aDecoder: NSCoder) {
        timer = Timer.init()
        bIsTimerStarted = false
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addParallaxToView(vView, intensity: 25)
        doRefresh(self)
    }
    
    @IBAction func doRefresh(_ sender: AnyObject) {
        game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
        updateVView(game)
    }
    
    @IBAction func doNext(_ sender: AnyObject) {
        game.next()
        updateVView(game)
    }
    
    @IBAction func doAnimate(_ sender: AnyObject) {
        let button = sender as! UIButton
        if bIsTimerStarted {
            button.setTitle("Start", for: UIControlState())
            bIsTimerStarted = false
            timer.invalidate()
        } else {
            button.setTitle("Stop", for: UIControlState())
            bIsTimerStarted = true
            updateTimer(getLogarithmicValue(slider.value))
        }
    }
    
    @IBAction func doValueChanged(_ sender: AnyObject) {
        if bIsTimerStarted {
            updateTimer(getLogarithmicValue(slider.value))
        }
    }
    
    func updateVView(_ g: Game) {
        lblTitle.text = "Generation \(g.generation). Living \(g.entities.count)"
        vView.game = g
        vView.setNeedsDisplay()
    }
    
    func updateTimer(_ fValue: Double) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: fValue, target: self, selector: #selector(doNext), userInfo: nil, repeats: true)
    }
    
    func getLogarithmicValue(_ fValue:Float) -> Double {
        let max = 5.0
        let out = (exp(Double(fValue) * max) - 1.0) / exp(max)
        return round(out * 1000)/1000
    }
    
    func addParallaxToView(_ view:UIView, intensity:CGFloat) {
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -intensity
        verticalMotionEffect.maximumRelativeValue = intensity
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -intensity
        horizontalMotionEffect.maximumRelativeValue = intensity
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        view.addMotionEffect(group)
    }
}

