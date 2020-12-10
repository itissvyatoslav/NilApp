//
//  FinishBankViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 05.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import AVFoundation

class FinishBankViewController: UIViewController {
    
    var isRub = false
    
    var toPhone = false
    
    var cardNumber = ""
    
    var contactName = ""
    var contactPhone = ""
    var oldSumm = 0
    var newSumm: Double = 0
    var transactionSumm: Double =  0
    var comment = ""
    var summ: Double = 0
    
    var isTappedReady = false
    
    var isGood = true
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newSummLabel: UILabel!
    
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var readyButton: UIButton!
    
    
    @IBOutlet weak var pushView: UIView!
    @IBOutlet weak var pushNameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    @IBAction func shopTapped(_ sender: Any) {
        var numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } else if numberLights == 500 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            numberLights -= 1
            UserDefaults.standard.set(numberLights, forKey: "lights")
            //shopLabel.text = "\(numberLights)"
        }
    }
    
    private func setLights() {
        let numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights != 500 {
            //shopLabel.text = "\(numberLights)"
        } else {
            //shopLabel.text = "∞"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView(){
        shopView.layer.cornerRadius = 20
        cardNumberLabel.text = cardNumber
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedUp))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.pushView.addGestureRecognizer(swipeUp)
        pushView.layer.cornerRadius = 20
        pushView.isHidden = true
        pushView.center.y -= 90
        cardView.layer.cornerRadius = 20
        checkView.layer.cornerRadius = 20
        readyButton.layer.cornerRadius = 11
        nameLabel.text = contactName
        phoneLabel.text = contactPhone
        commentLabel.text = comment
        if isRub {
            moneyLabel.text = "\(oldSumm) ₽"
            newSummLabel.text = "\(newSumm) ₽"
            summLabel.text = "\(transactionSumm) ₽"
            taxLabel.text = "комиссия составила \(summ - transactionSumm)₽"
        } else {
            moneyLabel.text = "\(oldSumm) $"
            newSummLabel.text = "\(newSumm) $"
            summLabel.text = "\(transactionSumm) $"
            taxLabel.text = "комиссия составила \(summ - transactionSumm)$"
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @objc func didSwipedUp() {
        UIView.animate(withDuration: 0.4) {
            self.pushView.center.y -= 180
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewControllers(viewsToPop: 6)
    }
    
    @IBAction func readyTapped(_ sender: Any) {
        if !isTappedReady {
            isTappedReady = true
            checkResult()
        } else {
            if isGood {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "GoodFinishViewController") as! GoodFinishViewController
                vc.vcID = 2
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let number = Int.random(in: 1...10)
                if number % 2 == 0 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "FirstBadFinishViewController") as! FirstBadFinishViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SecondBadViewController") as! SecondBadViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    private func checkResult(){
        startMusic()
        var textMessage: String = ""
        
        if transactionSumm != 1300 {
            isGood = false
            textMessage = "Ты же мне 98 должен был"
        }
        
        if comment != "за бензин"{
            isGood = false
            textMessage = "Спасибо, а за что?"
        }
        
        if contactPhone != "+7 (213) 543-34-32" {
            isGood = false
            textMessage = "Ты походу не тому отправил, сейчас переведу обратно"
        }
        
        if toPhone {
            isGood = false
            textMessage = "А зачем на номер телефона? Надо было на карту.."
        }
        
        if cardNumber != "**** 4591" {
            isGood = false
            textMessage = "Так надо же было с карты жены"
        }
        
        if !isRub {
            isGood = false
            textMessage = "А долларами зачем?"
        }
        if isGood {
            textMessage = "Спасибо, что вернул в срок!"
        }
        
        
        
        pushNameLabel.text = contactName
        textLabel.text = textMessage
        
        
        pushView.isHidden = false
        UIView.animate(withDuration: 1) {
            self.pushView.center.y += 90
        }
    }
    
    var AudioPlayer = AVAudioPlayer()
    
    private func startMusic(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "PushSound", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = 0
        AudioPlayer.play()
    }
}
