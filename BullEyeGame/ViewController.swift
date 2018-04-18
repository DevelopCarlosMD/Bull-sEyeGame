//
//  ViewController.swift
//  BullEyeGame
//
//  Created by hassassin1 on 3/22/18.
//  Copyright © 2018 CDS. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round: Int = 0
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //currentValue = lroundf(slider.value)
        //targetValue = 1 + Int(arc4random_uniform(100))
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightRezisable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightRezisable, for: .normal)
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        //let title = getTitleUser(difference: difference)
        let message = "You scored \(points) points"
            /*"The value of the slider is: \(currentValue)"
            + "\nThe target values is:\(targetValue)"
            + "\nThe difference is: \(difference)"
            + "You scored \(points) points"*/
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil/*{ action in
            self.startNewRound(eventFlag: false)
            self.updateLabels()
        }*/)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        startNewRound(eventFlag: false)
        updateLabels()
    }
   
    @IBAction func sliderMoved(_ slider: UISlider) {
      currentValue = lroundf(slider.value)
        //print("The value of the slider is now: \(slider.value)")
    }
    @IBAction func startOver(){
        startNewGame()
        updateLabels()
    }
    func startNewRound(eventFlag: Bool) {
        targetValue = 1 + Int(arc4random_uniform(100))
        round += 1
        if eventFlag {
            currentValue = 50
            slider.value = Float(currentValue)
        }
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound(eventFlag: true)
        // Add the following lines
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
                                    kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func getTitleUser(difference: Int) -> String {
        if difference == 0{
            return "Perfect"
        } else if difference < 5 {
            return "You almost had it!"
        } else if difference < 10 {
            return "Pretty good!"
        }else {
            return "Not even close..."
        }
    }
    
    /*func getDifference() -> Int {
        var difference: Int = 0
        // Approach 1
        /*if currentValue > targetValue {
            difference = currentValue - targetValue
        } else if targetValue > currentValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        }*/
        // Approach 2
        /*difference = currentValue - targetValue
        if difference < 0 {
            difference = -difference
        }*/
        return difference
    }*/
}

