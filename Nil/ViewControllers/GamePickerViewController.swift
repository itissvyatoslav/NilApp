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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    private func setView() {
        shopView.layer.cornerRadius = 20
        yellowButton.layer.cornerRadius = 60
        firstGrayButton.layer.cornerRadius = 60
        secondGrayButton.layer.cornerRadius = 60
        thirdGrayButton.layer.cornerRadius = 60
    }
    
    //MARK:- ACTIONS
    
    @IBAction func cinemaTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.idTask = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bankTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.idTask = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func hospitalTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.idTask = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func aviaTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.idTask = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shopTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
        vc.idVC = 1
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
