//
//  ViewController.swift
//  Game of Life
//
//  Created by Adrian Florescu on 20.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var gameView: GameView!
    @IBOutlet weak var gameInfo: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    var game: Game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
    var timer: Timer
    var isStarted: Bool
    
    required init?(coder aDecoder: NSCoder) {
        timer = Timer.init()
        isStarted = false
        playButton.tintColor = UIColor.yellow
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addParallaxToView(gameView, intensity: 25)
        doRefresh(self)
    }
    
    @IBAction func doRefresh(_ sender: AnyObject) {
        game = Game(nrOfEntities: 30, x: 10, y: 10, width: 10, height: 10)
        updateGameView(game)
    }
    
    @IBAction func doNext(_ sender: AnyObject) {
        game.next()
        updateGameView(game)
    }
    
    @IBAction func doAnimate(_ sender: AnyObject) {
        let button = sender as! UIButton
        if isStarted {
            button.setTitle("Start", for: UIControlState())
            isStarted = false
            timer.invalidate()
        } else {
            button.setTitle("Stop", for: UIControlState())
            isStarted = true
            updateTimer(getLogarithmicValue(slider.value))
        }
    }
    
    @IBAction func doValueChanged(_ sender: AnyObject) {
        if isStarted {
            updateTimer(getLogarithmicValue(slider.value))
        }
    }
    
    func updateGameView(_ g: Game) {
        gameInfo.text = "Generation \(g.generation). Living \(g.entities.count)"
        gameView.game = g
        gameView.setNeedsDisplay()
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

