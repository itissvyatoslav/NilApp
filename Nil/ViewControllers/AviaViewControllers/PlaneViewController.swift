//
//  PlaneViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 02.12.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PlaneViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var firstPlaneView: UIView!
    @IBOutlet weak var secondPlaneView: UIView!
    @IBOutlet weak var thirdPlaneView: UIView!
    @IBOutlet weak var forthPlaneView: UIView!
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    var isBuggage = false
    var fromCity = ""
    var toCity = ""
    var fromTime = ""
    var toTime = ""
    var isFreeDays = false
    var fromDate = ""
    var toDate = ""
    var peopleCount = 0
    var sliderCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView() {
        shopView.layer.cornerRadius = 20
        firstPlaneView.layer.cornerRadius = 30
        secondPlaneView.layer.cornerRadius = 30
        thirdPlaneView.layer.cornerRadius = 30
        forthPlaneView.layer.cornerRadius = 30
        nextButton.layer.cornerRadius = 11
        setBoarders()
    }
    
    private func setBoarders() {
        firstPlaneView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        firstPlaneView.layer.borderWidth = 1
        secondPlaneView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        secondPlaneView.layer.borderWidth = 1
        thirdPlaneView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        thirdPlaneView.layer.borderWidth = 1
        forthPlaneView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        forthPlaneView.layer.borderWidth = 1
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    var isPlaneCorrect = false
    
    @IBAction func firstPlaneTapped(_ sender: Any) {
        isPlaneCorrect = false
        setBoarders()
        firstPlaneView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func secondPlaneTapped(_ sender: Any) {
        isPlaneCorrect = true
        setBoarders()
        secondPlaneView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func thirdPlaneTapped(_ sender: Any) {
        isPlaneCorrect = false
        setBoarders()
        thirdPlaneView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func forthPlaneTapped(_ sender: Any) {
        isPlaneCorrect = false
        setBoarders()
        forthPlaneView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        checkResult()
    }
    
    
    func checkResult() {
        if peopleCount == 1 && sliderCount == 1 && isBuggage && fromCity == "Current location" && toCity == "Barselona" && isFreeDays && checkDate() && toTime == "19:0" && isPlaneCorrect {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GoodFinishViewController") as! GoodFinishViewController
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
    
    func checkDate() -> Bool {
        var result = false
        
        let componentsFrom = fromDate.components(separatedBy: " ")
        let componentsTo = toDate.components(separatedBy: " ")
        
        let dayFrom = Int(componentsFrom[0]) ?? 0
        let dayTo = Int(componentsTo[0]) ?? 90
        
        let monthFrom = componentsFrom[1]
        let monthTo = componentsTo[1]
        
        let yearFrom = componentsFrom[2]
        let yearTo = componentsTo[2]
        
        if ((dayTo - dayFrom) == 0 || (dayTo - dayFrom) == 1) && monthFrom == "август" && monthTo == "август" && yearFrom == yearTo {
            result = true
        }
        
        
        return result
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
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
}
