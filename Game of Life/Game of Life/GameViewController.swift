//
//  ViewController.swift
//  Game of Life
//
//  Created by Adrian Florescu on 20.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var txtText: UITextView!
    var g:Game?
    //private var timer
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
//        g = Game(nrOfEntities: 30, x: 10, y: 10)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtText.text = "Hello world!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doRefresh(sender: AnyObject) {
        g = Game(nrOfEntities: 30, x: 10, y: 10)
        if let gU = g {
            var txt:String = ""
            txt += "Game has \(gU.entities.count) entities...\n"
            txt += GameTextView.getText(game: gU, x: -10, y: -10, rows: 30, cols: 55)
            txtText.text = txt
        }
    }
    
    @IBAction func doNext(sender: AnyObject) {
        if let gU = g {
            var txt:String = ""
            gU.next()
            txt += "Generation \(gU.generation)\n"
            txt += "===========================\n"
            txt += GameTextView.getText(game: gU, x: -10, y: -10, rows: 30, cols: 55)
            txtText.text = txt
        }
    }
    
    @IBAction func doAnimate(sender: AnyObject) {
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(doNext), userInfo: nil, repeats: true)
    }
}

