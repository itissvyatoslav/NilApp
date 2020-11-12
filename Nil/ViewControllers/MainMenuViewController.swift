//
//  MainMenuViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 29.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var bigGreenView: UIView!
    @IBOutlet weak var smallBlackView: UIView!
    @IBOutlet weak var tappedBigGreenView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    private var isSwiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        hideNavigationBar()
    }
    
    private func setViews(){
        self.tappedBigGreenView.alpha = 0
        
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
    
    @objc func didSwipedUp() {
        if !isSwiped {
            UIView.animate(withDuration: 0.3) {
                self.tappedBigGreenView.center.y -= 50
                self.bigGreenView.center.y -= 50
                self.smallBlackView.center.y += 50
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
            //let storyboard = UIStoryboard(name: "Tickets", bundle: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            vc.idTask = 0
            self.navigationController?.pushViewController(vc, animated: true)
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            vc.idTask = 1
            self.navigationController?.pushViewController(vc, animated: true)
           // let storyboard = UIStoryboard(name: "Bank", bundle: nil)
           // let vc = storyboard.instantiateViewController(withIdentifier: //"MainBankViewController") as! MainBankViewController
           // self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func hospitalAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.idTask = 2
        self.navigationController?.pushViewController(vc, animated: true)
       // let storyboard = UIStoryboard(name: "Hospital", bundle: nil)
       // let vc = storyboard.instantiateViewController(withIdentifier: //"MainHospitalViewController") as! MainHospitalViewController
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
