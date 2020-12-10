//
//  MainMenuViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 29.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import AVFoundation

class MainMenuViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var bigGreenView: UIView!
    @IBOutlet weak var smallBlackView: UIView!
    @IBOutlet weak var tappedBigGreenView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var fingerImage: UIImageView!
    
    
    private var isSwiped = false
    var isFirstEnter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        hideNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fingerImage.alpha = 0
        if isFirstEnter {
            bigGreenView.alpha = 0
            smallBlackView.alpha = 0
            tappedBigGreenView.alpha = 0
            backgroundView.alpha = 1
            UIView.animate(withDuration: 0.5) { [self] in
                bigGreenView.alpha = 1
                backgroundView.alpha = 1
                smallBlackView.alpha = 1
            }
            isFirstEnter = false
        }
    }
    
    private func setViews(){
        self.tappedBigGreenView.alpha = 0
        createTimer()
        tappedBigGreenView.layer.cornerRadius = (UIScreen.main.bounds.width - 180) / 2 * 1.2
        bigGreenView.layer.cornerRadius = (UIScreen.main.bounds.width - 180) / 2
        smallBlackView.layer.cornerRadius = (UIScreen.main.bounds.width - 300) / 2
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedUp))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.bigGreenView.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedDown))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.bigGreenView.addGestureRecognizer(swipeDown)
    }
    var AudioPlayer = AVAudioPlayer()
    
    private func startMusic(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "unlock", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = 0
        AudioPlayer.play()
    }
    
    @objc func didSwipedUp() {
        if !isSwiped {
            UIView.animate(withDuration: 0.3) {
                self.tappedBigGreenView.center.y -= 50
                self.bigGreenView.center.y -= 50
                self.smallBlackView.center.y += 50
                self.startMusic()
            }
            UIView.animate(withDuration: 0.7) {
                self.tappedBigGreenView.center.y -= 10
                self.bigGreenView.center.y -= 10
                self.smallBlackView.center.y += 20
            }
            isSwiped = true
        }
    }
    
    @objc func didSwipedDown() {
        if isSwiped {
            isSwiped = false
            UIView.animate(withDuration: 0.3) {
                self.tappedBigGreenView.center.y += 50
                self.bigGreenView.center.y += 50
                self.smallBlackView.center.y -= 50
            }
            UIView.animate(withDuration: 0.7) {
                self.tappedBigGreenView.center.y += 10
                self.bigGreenView.center.y += 10
                self.smallBlackView.center.y -= 20
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK:- Tap Views
    
    @IBAction func tapGreenView(_ sender: Any) {
        if isSwiped {
            let isNotFirstEnter = UserDefaults.standard.bool(forKey: "firstEnter")
            
            if isNotFirstEnter {
                let vc = storyboard?.instantiateViewController(withIdentifier: "GamePickerViewController") as! GamePickerViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                vc.idTask = 3
                self.navigationController?.pushViewController(vc, animated: false)
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.tappedBigGreenView.alpha = 1
            }
            UIView.animate(withDuration: 1) {
                self.tappedBigGreenView.alpha = 0
            }
        }
    }
    
    @IBAction func tapBlackView(_ sender: Any) {
        if isSwiped {

        } else {
            UIView.animate(withDuration: 1) {
                self.backgroundView.center.y -= 25
                self.smallBlackView.center.y -= 25
            }
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.center.y += 25
                self.smallBlackView.center.y += 25
            }
        }
    }

    
    //MARK:- TIMER
    
    var timer = Timer()
    var seconds = 7
    
    func createTimer(){
        timer.tolerance = 0.1
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        if seconds == 0 && !isSwiped {
            seconds = 7
            createTimer()
            timer.invalidate()
            //fingerImage.alpha = 1
            UIView.animate(withDuration: 1) {
                self.tappedBigGreenView.center.y -= 30
                self.bigGreenView.center.y -= 30
                self.smallBlackView.center.y += 30
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800), execute: {
                UIView.animate(withDuration: 1) {
                    self.tappedBigGreenView.center.y += 30
                    self.bigGreenView.center.y += 30
                    self.smallBlackView.center.y -= 30
                }
            })
        }
    }
}
