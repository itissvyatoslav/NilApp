//
//  CornViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 26.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import AVFoundation

class CornViewController: UIViewController {
    
    @IBOutlet weak var readyButton: UIButton!
    
    //MARK:- POPS
    @IBOutlet weak var pop1: UIImageView!
    @IBOutlet weak var pop2: UIImageView!
    @IBOutlet weak var pop3: UIImageView!
    @IBOutlet weak var pop4: UIImageView!
    @IBOutlet weak var pop5: UIImageView!
    @IBOutlet weak var pop6: UIImageView!
    @IBOutlet weak var pop7: UIImageView!
    @IBOutlet weak var pop8: UIImageView!
    @IBOutlet weak var pop9: UIImageView!
    @IBOutlet weak var pop10: UIImageView!
    @IBOutlet weak var pop11: UIImageView!
    
    var isCorrectFilm = false
    var isCorrectSeat = false
    var isCorrectTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView() {
        readyButton.isHidden = true
        readyButton.layer.cornerRadius = 11
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    var isCornTapped = false
    
    @IBAction func cornTapped(_ sender: Any) {
        if !isCornTapped {
            readyButton.isHidden = false
            readyButton.alpha = 0
            startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                UIView.animate(withDuration: 1) {
                    self.readyButton.alpha = 1
                }
                self.isCornTapped = true
            })
        }
    }
    
    @IBAction func readyTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        vc.isCorrectFilm = self.isCorrectFilm
        vc.isCorrectSeat = self.isCorrectSeat
        vc.isCorrectTime = self.isCorrectTime
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.7) { [self] in
            pop1.center.x = 0
            pop1.center.y = 0
            pop2.center.x = UIScreen.main.bounds.width / 2
            pop2.center.y = 0
            pop3.center.x = UIScreen.main.bounds.width
            pop3.center.y = 0
            pop4.center.x = 0
            pop4.center.y = UIScreen.main.bounds.height / 3
            pop5.center.x = 0
            pop5.center.y = UIScreen.main.bounds.height * 2 / 3
            pop6.center.x = 0
            pop6.center.y = UIScreen.main.bounds.height
            pop7.center.x = UIScreen.main.bounds.width
            pop7.center.y = UIScreen.main.bounds.height
            pop8.center.x = UIScreen.main.bounds.width
            pop8.center.y = UIScreen.main.bounds.height / 3
            pop9.center.x = UIScreen.main.bounds.width
            pop9.center.y = UIScreen.main.bounds.height * 2 / 3
            pop10.center.x = UIScreen.main.bounds.width / 2
            pop10.center.y = UIScreen.main.bounds.height
            pop11.center.x = UIScreen.main.bounds.width / 3
            pop11.center.y = UIScreen.main.bounds.height
        }
        startMusic()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.AudioPlayer.stop()
        })
    }
    
    var AudioPlayer = AVAudioPlayer()
    
    private func startMusic(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "pop", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = 0
        AudioPlayer.play()
    }
}
