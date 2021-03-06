//
//  FinishHospitalViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 07.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FinishHospitalViewController: UIViewController, GADInterstitialDelegate {
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    
    var doctorName = ""
    var room = ""
    var date = ""
    var time = ""
    var name = ""
    var birthday = ""
    var phone = ""
    var email = ""
    var isMale = false
    
    //MARK:-OUTLETS
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var FTickButton: UIButton!
    @IBOutlet weak var MTickButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var hospitalsTable: UITableView!
    @IBOutlet weak var shopView: UIView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
    
    private func setLights() {
        let numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights != 500 {
            //shopLabel.text = "\(numberLights)"
        } else {
            //shopLabel.text = "∞"
        }
    }
    
    override func viewDidLoad() {
        messageView.alpha = 0
        messageView.layer.cornerRadius = 20
        messageView.center.y -= 90
        shopView.layer.cornerRadius = 20
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        interstitial = createAndLoadInterstitial()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func setView(){
        hospitalsTable.isHidden = true
        doctorNameLabel.text = doctorName
        roomLabel.text = room
        dateLabel.text = date
        timeLabel.text = time
        nameLabel.text = name
        birthdayLabel.text = birthday
        phoneLabel.text = phone
        emailLabel.text = email
        hospitalsTable.delegate = self
        hospitalsTable.dataSource = self
        nextButton.layer.cornerRadius = 10
        if isMale {
            MTickButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            FTickButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    //MARK:- TOP BUTTONS ACTION
    
    @IBAction func mainAction(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as
            Array {
                if controller.isKind(of:
                    MainHospitalViewController.self) {
                    _ =
                        self.navigationController!.popToViewController(controller,
                                                                       animated: false)
                    break
                }
        }
    }
    
    @IBAction func doctorsAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func receptionAction(_ sender: Any) {
        hospitalsTable.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.hospitalsTable.isHidden = true
        })
    }
    
    //MARK:- SHOW AD
    
    var interstitial: GADInterstitial!
    
    let areAdsDeleted = UserDefaults.standard.bool(forKey: "areAdsDeleted")
    
    func createAndLoadInterstitial() -> GADInterstitial {
      var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
      interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
    }
    
    @IBAction func firstMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func secondMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func thirdMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func forthMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func fifthMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func sixthMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func readyAction(_ sender: Any) {
        checkResult()
    }
    
    private func checkResult() {
        let date2 = Date()
        let calendar = Calendar.current
        let nextCalendar = Calendar.current.date(byAdding: .day, value: +1, to: date2)
        let nextDay = calendar.component(.day, from: nextCalendar!)
        let nextMonth = calendar.component(.month, from: nextCalendar!)
        let nextYear = calendar.component(.year, from: nextCalendar!)
        if doctorName == "Ларина Полина Петровна" && room == "каб. 409" && date == "\(nextDay).\(nextMonth).\(nextYear)" && time == "13:00" && checkTextFields(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GoodFinishViewController") as! GoodFinishViewController
            vc.vcID = 1
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
    
    private func checkTextFields() -> Bool {
        var isGood = true
        if !email.contains("@") {
            isGood = false
        }
        let letters = NSCharacterSet.letters
        let range = phone.rangeOfCharacter(from: letters)
        let range2 = birthday.rangeOfCharacter(from: letters)
        if range != nil || range2 != nil {
            isGood = false
        }
        
        return isGood
    }
    
}

extension FinishHospitalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hospitalCell")
        cell.textLabel?.text = hospitals[indexPath.row]
        cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            self.navigationController?.popViewControllers(viewsToPop: 3, animated: false)
        }
    }
}
