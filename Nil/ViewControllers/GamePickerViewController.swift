//
//  GamePickerViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 01.12.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class GamePickerViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var firstGrayButton: UIButton!
    @IBOutlet weak var secondGrayButton: UIButton!
    @IBOutlet weak var thirdGrayButton: UIButton!
    
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var underShopView: UIView!
    
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var underPlayView: UIView!
    
    
    @IBOutlet weak var firstButtonView: UIView!
    @IBOutlet weak var secondButtonView: UIView!
    @IBOutlet weak var thirdButtonView: UIView!
    @IBOutlet weak var forthButtonView: UIView!
    
    @IBOutlet weak var hospitalTimer: UILabel!
    @IBOutlet weak var bankTimer: UILabel!
    @IBOutlet weak var aviaTimer: UILabel!
    
    
    //@IBOutlet weak var timerBankLabel: UILabel!
    let is0Finished = UserDefaults.standard.bool(forKey: "is0Finished")
    let is1Finished = UserDefaults.standard.bool(forKey: "is1Finished")
    let is2Finished = UserDefaults.standard.bool(forKey: "is2Finished")
    let is3Finished = UserDefaults.standard.bool(forKey: "is3Finished")
    
    var timer = Timer()
    //var time = 1799
    var minutes = 0
    var seconds = 0
    
    var can1Play = false
    var can2Play = false
    var can3Play = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        setButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let areAdsDeleted = UserDefaults.standard.bool(forKey: "areAdsDeleted")
        if areAdsDeleted {
            shopView.isHidden = true
            underShopView.isHidden = true
        }
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    private func setView() {
        let areAdsDeleted = UserDefaults.standard.bool(forKey: "areAdsDeleted")
        if areAdsDeleted {
            shopView.isHidden = true
            underShopView.isHidden = true
        }
        underPlayView.isHidden = true
        playButtonView.isHidden = true
        underPlayView.layer.cornerRadius = 30
        playButtonView.layer.cornerRadius = 30
        underShopView.layer.cornerRadius = 26
        shopView.layer.cornerRadius = 26
        yellowButton.layer.cornerRadius = 60
        firstGrayButton.layer.cornerRadius = 60
        secondGrayButton.layer.cornerRadius = 60
        thirdGrayButton.layer.cornerRadius = 60
    }
    
    
    //MARK:- ACTIONS
    
    var missWaitingID = 0
    
    @IBAction func missWaitingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
        vc.idVC = 2
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func cinemaTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.idTask = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bankTapped(_ sender: Any) {
        if can2Play {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            vc.idTask = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func hospitalTapped(_ sender: Any) {
        if can1Play {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            vc.idTask = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func aviaTapped(_ sender: Any) {
        if can3Play {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            vc.idTask = 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func shopTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
        vc.idVC = 1
        //vc.modalPresentationStyle = .overCurrentContext
        //vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension GamePickerViewController {
    //MARK:- TIMERS
    
    private func setButtons() {
        yellowButton.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        if is0Finished {
            firstButtonView.isHidden = true
            checkHospitalTimer()
            if !is1Finished {
                secondButtonView.layer.cornerRadius = 60
                thirdButtonView.layer.cornerRadius = 60
                thirdButtonView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                forthButtonView.layer.cornerRadius = 60
                forthButtonView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
            } else {
                secondButtonView.isHidden = true
                checkBankTimer()
                if !is2Finished {
                    thirdButtonView.layer.cornerRadius = 60
                    forthButtonView.layer.cornerRadius = 60
                    forthButtonView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                } else {
                    thirdButtonView.isHidden = true
                    checkAviaTimer()
                    if !is3Finished {
                        forthButtonView.layer.cornerRadius = 60
                    } else {
                        forthButtonView.isHidden = true
                        yellowButton.backgroundColor = UIColor(red: 1, green: 218/255, blue: 135/255, alpha: 1)
                    }
                }
            }
        } else {
            firstButtonView.layer.cornerRadius = 60
            firstButtonView.backgroundColor = UIColor(red: 0, green: 206/255, blue: 168/255, alpha: 1)
            secondButtonView.layer.cornerRadius = 60
            secondButtonView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
            thirdButtonView.layer.cornerRadius = 60
            thirdButtonView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
            forthButtonView.layer.cornerRadius = 60
            forthButtonView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        }
    }
    
    func checkHospitalTimer() {
        let finishHospitalTimer = UserDefaults.standard.object(forKey: "hospitalTimeOpen") as! Date
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([ .second])
        let dateComponents = calendar.dateComponents(unitFlags, from: Date(), to: finishHospitalTimer)
        let seconds = dateComponents.second
        if seconds ?? 0 > 0 {
            missWaitingID = 1
            underPlayView.isHidden = false
            playButtonView.isHidden = false
            secondButtonView.backgroundColor = UIColor(red: 1, green: 218/255, blue: 135/255, alpha: 1)
            createTimerHospital(time: seconds!)
        } else {
            secondButtonView.backgroundColor = UIColor(red: 156/255, green: 196/255, blue: 229/255, alpha: 1)
            can1Play = true
        }
    }

    func createTimerHospital(time: Int) {
        minutes = Int(time) / 60 % 60
        seconds = Int(time) % 60
        timer.tolerance = 0.1
        //if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimerHospital),
                                         userInfo: nil,
                                         repeats: true)
        //}
    }
    
    @objc func updateTimerHospital() {
        seconds -= 1
        if seconds <= 0 {
            if minutes == 0 {
                timer.invalidate()
                can1Play = true
                hospitalTimer.text = ""
                missWaitingID = 0
                UIView.animate(withDuration: 1) {
                    self.underPlayView.isHidden = true
                    self.playButtonView.isHidden = true
                    self.secondButtonView.backgroundColor = UIColor(red: 156/255, green: 196/255, blue: 229/255, alpha: 1)
                }
            } else {
                minutes -= 1
                seconds = 59
                if minutes < 10 && seconds < 10 {
                    hospitalTimer.text = "0\(minutes):0\(seconds)"
                } else if minutes < 10 && seconds > 9 {
                    hospitalTimer.text = "0\(minutes):\(seconds)"
                } else if minutes > 9 && seconds < 10 {
                    hospitalTimer.text = "\(minutes):0\(seconds)"
                } else {
                    hospitalTimer.text = "\(minutes):\(seconds)"
                }
            }
        } else {
            if minutes < 10 && seconds < 10 {
                hospitalTimer.text = "0\(minutes):0\(seconds)"
            } else if minutes < 10 && seconds > 9 {
                hospitalTimer.text = "0\(minutes):\(seconds)"
            } else if minutes > 9 && seconds < 10 {
                hospitalTimer.text = "\(minutes):0\(seconds)"
            } else {
                hospitalTimer.text = "\(minutes):\(seconds)"
            }
        }
    }
    
    func checkBankTimer() {
        let finishHospitalTimer = UserDefaults.standard.object(forKey: "bankTimeOpen") as! Date
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([ .second])
        let dateComponents = calendar.dateComponents(unitFlags, from: Date(), to: finishHospitalTimer)
        let seconds = dateComponents.second
        if seconds ?? 0 > 0 {
            missWaitingID = 2
            underPlayView.isHidden = false
            playButtonView.isHidden = false
            thirdButtonView.backgroundColor = UIColor(red: 1, green: 218/255, blue: 135/255, alpha: 1)
            createTimerBank(time: seconds!)
        } else {
            thirdButtonView.backgroundColor = UIColor(red: 1, green: 146/255, blue: 134/255, alpha: 1)
            can2Play = true
        }
    }

    func createTimerBank(time: Int) {
        minutes = Int(time) / 60 % 60
        seconds = Int(time) % 60
        timer.tolerance = 0.1
        //if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimerBank),
                                         userInfo: nil,
                                         repeats: true)
        //}
    }
    
    @objc func updateTimerBank() {
        seconds -= 1
        if seconds <= 0 {
            if minutes == 0 {
                timer.invalidate()
                can2Play = true
                missWaitingID = 0
                bankTimer.text = ""
                UIView.animate(withDuration: 1) {
                    self.underPlayView.isHidden = true
                    self.playButtonView.isHidden = true
                    self.thirdButtonView.backgroundColor = UIColor(red: 1, green: 146/255, blue: 134/255, alpha: 1)
                }
            } else {
                minutes -= 1
                seconds = 59
                if minutes < 10 && seconds < 10 {
                    bankTimer.text = "0\(minutes):0\(seconds)"
                } else if minutes < 10 && seconds > 9 {
                    bankTimer.text = "0\(minutes):\(seconds)"
                } else if minutes > 9 && seconds < 10 {
                    bankTimer.text = "\(minutes):0\(seconds)"
                } else {
                    bankTimer.text = "\(minutes):\(seconds)"
                }
            }
        } else {
            if minutes < 10 && seconds < 10 {
                bankTimer.text = "0\(minutes):0\(seconds)"
            } else if minutes < 10 && seconds > 9 {
                bankTimer.text = "0\(minutes):\(seconds)"
            } else if minutes > 9 && seconds < 10 {
                bankTimer.text = "\(minutes):0\(seconds)"
            } else {
                bankTimer.text = "\(minutes):\(seconds)"
            }
        }
    }
    
    func checkAviaTimer() {
        let finishHospitalTimer = UserDefaults.standard.object(forKey: "aviaTimeOpen") as! Date
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([ .second])
        let dateComponents = calendar.dateComponents(unitFlags, from: Date(), to: finishHospitalTimer)
        let seconds = dateComponents.second
        if seconds ?? 0 > 0 {
            underPlayView.isHidden = false
            playButtonView.isHidden = false
            forthButtonView.backgroundColor = UIColor(red: 1, green: 218/255, blue: 135/255, alpha: 1)
            missWaitingID = 3
            createTimerAvia(time: seconds!)
        } else {
            forthButtonView.backgroundColor = UIColor(red: 92/255, green: 172/255, blue: 197/255, alpha: 1)
            can3Play = true
        }
    }

    func createTimerAvia(time: Int) {
        minutes = Int(time) / 60 % 60
        seconds = Int(time) % 60
        timer.tolerance = 0.1
        //if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimerAvia),
                                         userInfo: nil,
                                         repeats: true)
        //}
    }
    
    @objc func updateTimerAvia() {
        seconds -= 1
        if seconds <= 0 {
            if minutes == 0 {
                timer.invalidate()
                missWaitingID = 0
                can3Play = true
                aviaTimer.text = ""
                UIView.animate(withDuration: 1) {
                    self.underPlayView.isHidden = true
                    self.playButtonView.isHidden = true
                    self.forthButtonView.backgroundColor = UIColor(red: 92/255, green: 172/255, blue: 197/255, alpha: 1)
                }
            } else {
                minutes -= 1
                seconds = 59
                if minutes < 10 && seconds < 10 {
                    aviaTimer.text = "0\(minutes):0\(seconds)"
                } else if minutes < 10 && seconds > 9 {
                    aviaTimer.text = "0\(minutes):\(seconds)"
                } else if minutes > 9 && seconds < 10 {
                    aviaTimer.text = "\(minutes):0\(seconds)"
                } else {
                    aviaTimer.text = "\(minutes):\(seconds)"
                }
            }
        } else {
            if minutes < 10 && seconds < 10 {
                aviaTimer.text = "0\(minutes):0\(seconds)"
            } else if minutes < 10 && seconds > 9 {
                aviaTimer.text = "0\(minutes):\(seconds)"
            } else if minutes > 9 && seconds < 10 {
                aviaTimer.text = "\(minutes):0\(seconds)"
            } else {
                aviaTimer.text = "\(minutes):\(seconds)"
            }
        }
    }
}

extension GamePickerViewController: ShopViewControllerDelegate {
    func cameFromMissing() {
        if missWaitingID == 1 {
            UserDefaults.standard.set(Date().add(seconds: 5), forKey: "hospitalTimeOpen")
        }
        if missWaitingID == 2 {
            UserDefaults.standard.set(Date().add(seconds: 5), forKey: "bankTimeOpen")
        }
        if missWaitingID == 3 {
            UserDefaults.standard.set(Date().add(seconds: 5), forKey: "aviaTimeOpen")
        }
        setButtons()
    }
}
