//
//  PeopleViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 30.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var isBuggage = false
    var fromCity = ""
    var toCity = ""
    var fromTime = ""
    var toTime = ""
    var isFreeDays = false
    var fromDate = ""
    var toDate = ""
    
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var peopleView: UIView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var childrenView: UIView!
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    
    var count = 0
    var isChildrenSelected = false
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        shopView.layer.cornerRadius = 20
        childrenView.isHidden = true
        slider.isHidden = true
        mainLabel.text = "Выберите сколько\nвас поедет"
        readyButton.layer.cornerRadius = 11
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    //MARK:- ACTIONS
    
    @IBAction func sliderChanged(_ sender: Any) {
        childrenCountLabel.text = "\(slider.value)"
    }
    
    
    @IBAction func minusTapped(_ sender: Any) {
        count += 2
        countLabel.text = "\(count)"
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        count -= 1
        countLabel.text = "\(count)"
    }
    
    @IBAction func readyTapped(_ sender: Any) {
        if isChildrenSelected {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlaneViewController") as! PlaneViewController
            vc.isBuggage = self.isBuggage
            vc.fromCity = self.fromCity
            vc.toCity = self.toCity
            vc.fromTime = self.fromTime
            vc.toTime = self.toTime
            vc.isFreeDays = self.isFreeDays
            vc.fromDate = self.fromDate
            vc.toDate = self.toDate
            vc.peopleCount = self.count
            vc.sliderCount = Int(slider.value)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            childrenView.isHidden = false
            slider.isHidden = false
            subLabel.text = "Детей"
            peopleView.isHidden = true
            isChildrenSelected = true
        }
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
