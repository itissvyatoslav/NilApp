//
//  PeopleViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 30.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var peopleView: UIView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var childrenView: UIView!
    @IBOutlet weak var childrenCountLabel: UILabel!
    
    var count = 0
    var isChildrenSelected = false
    
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
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
            
        } else {
            childrenView.isHidden = false
            slider.isHidden = false
            subLabel.text = "Детей"
            peopleView.isHidden = true
            isChildrenSelected = true
        }
    }
    // CHECK
}
