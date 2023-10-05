//
//  ViewController.swift
//  EggTimer
//
//  Created by Hitesh Moudgil on 2023-10-05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player : AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var hardness : String?
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        hardness = sender.currentTitle
        totalTime = (eggTimes[hardness!]!)
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }

    @objc func timerUpdate() {
        if(secondsPassed < totalTime) {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgress
        }
        else {
            timer.invalidate()
            titleLabel.text = "Done!!!"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}


