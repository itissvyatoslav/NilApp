//
//  DateViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 30.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    var fromCity = ""
    var toCity = ""
    var isBuggage = false
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var time1Label: UILabel!
    @IBOutlet weak var time2Label: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var closeKeyboard: UIButton!
    @IBOutlet weak var calendarImage: UIImageView!
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    
    
    var hour1 = 18
    var minute1 = 0
    
    var hour2 = 18
    var minute2 = 0
    
    var isFreeDays = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
        closeKeyboard.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillAppear() {
        UIView.animate(withDuration: 0.2) {
            self.closeKeyboard.alpha = 1
        }
    }

    @objc func keyboardWillDisappear() {
        UIView.animate(withDuration: 0.2) {
            self.closeKeyboard.alpha = 0
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func setView(){
        shopView.layer.cornerRadius = 20
        time1Label.text = "\(hour1):\(minute1)"
        time2Label.text = "\(hour2):\(minute2)"
        nextButton.layer.cornerRadius = 11
        mainLabel.text = "Выберите когда и на\nсколько Вас забрать"
        calendarImage.isHidden = true
    }
    
    //MARK:- ACTIONS
    
    @IBAction func time1Tapped(_ sender: Any) {
        minute1 += 1
        if minute1 == 60 {
            minute1 = 0
            hour1 += 1
            if hour1 == 24 {
                hour1 = 0
                minute1 = 0
            }
        }
        time1Label.text = "\(hour1):\(minute1)"
    }
    
    @IBAction func time2Tapped(_ sender: Any) {
        minute2 += 1
        if minute2 == 60 {
            minute2 = 0
            hour2 += 1
            if hour2 == 24 {
                hour2 = 0
                minute2 = 0
            }
        }
        time2Label.text = "\(hour2):\(minute2)"
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.closeKeyboard.alpha = 1
        }
        calendarImage.isHidden = !calendarImage.isHidden
    }
    
    @IBAction func date2Tapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.closeKeyboard.alpha = 1
        }
        calendarImage.isHidden = !calendarImage.isHidden
    }
    
    @IBAction func freeDaysTapped(_ sender: Any) {
        if isFreeDays {
            calendarImage.image = UIImage(named: "ill_calendar2")
        } else {
            calendarImage.image = UIImage(named: "ill_calendar")
        }
        isFreeDays = !isFreeDays
        print(isFreeDays)
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.view.endEditing(true)
        calendarImage.isHidden =  true
        UIView.animate(withDuration: 0.2) {
            self.closeKeyboard.alpha = 0
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "PeopleViewController") as! PeopleViewController
        vc.fromCity = self.fromCity
        vc.toCity = self.toCity
        vc.isBuggage = self.isBuggage
        vc.toTime = time2Label.text ?? ""
        vc.isFreeDays = self.isFreeDays
        vc.toDate = textField2.text ?? ""
        vc.fromDate = textField1.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

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
    
}
