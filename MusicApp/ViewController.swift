//
//  ViewController.swift
//  MusicApp
//
//  Created by Леся Булдакова on 17.03.2019.
//  Copyright © 2019 Леся Булдакова. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var timer = Timer()
    
    @IBOutlet weak var bachImage: UIImageView!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
  
    // MARK: actions
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func songSliderChanged(_ sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }
    @IBAction func playButtonClicked(_ sender: Any) {
        player.play()
        startTimer()
    }
    @IBAction func pauseButtonClicked(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        player.stop()
        timer.invalidate()
        player.currentTime = 0
        songSlider.value = 0
    }
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    createAudioPath ()
       viewAnimate ()
        setupSwipes ()
    }
    
   // MARK: setup animation for a view
    func viewAnimate () {
        bachImage.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIView.animate(withDuration: 1) {
            self.bachImage.frame = CGRect(x: 50, y: 250, width: 300, height: 300)
        }
    }
    
    // MARK: setup player
    func createAudioPath () {
        let audioPath = Bundle.main.path(forResource: "bachSong", ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: (audioPath)!))
            songSlider.maximumValue = Float(player.duration)
        } catch {
         // error
        }
    }
    @objc func changeSongSliderPositionWhilePlaying () {
        songSlider.value = Float(player.currentTime)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeSongSliderPositionWhilePlaying), userInfo: nil, repeats: true)
    }
    
    // MARK:- shake handler
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            print("device was shaken")
            //  чтобы проверить шэйки, запускаем сумулятор в том же окне, где исккод, в настройках симулятора  hardware/ shake gesture
        }
    }
    
    // MARK: setup swipes
    
    func setupSwipes () {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        rightSwipe.direction = .left
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swiped(gesture: UISwipeGestureRecognizer) {
        if  let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                print("swiped right ")
            case .left:
                 print("swiped left ")
            default:
                break
            }
        }
        
        
      
    }
   
}



