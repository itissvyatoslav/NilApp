//
//  CinemaTimeViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 26.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class CinemaTimeViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var forthView: UIView!
    @IBOutlet weak var fifthView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var isCorrectFilm = false
    var isCorrectSeat = false
    var isCorrectTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView() {
        setBorders()
        firstView.layer.cornerRadius = 5
        secondView.layer.cornerRadius = 5
        thirdView.layer.cornerRadius = 5
        forthView.layer.cornerRadius = 5
        fifthView.layer.cornerRadius = 5
        nextButton.layer.cornerRadius = 11
    }
    
    private func setBorders() {
        firstView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        firstView.layer.borderWidth = 1
        secondView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        secondView.layer.borderWidth = 1
        thirdView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        thirdView.layer.borderWidth = 1
        forthView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        forthView.layer.borderWidth = 1
        fifthView.layer.borderColor = CGColor(red: 178/255, green: 175/255, blue: 202/255, alpha: 1)
        fifthView.layer.borderWidth = 1
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func firstTapped(_ sender: Any) {
        setBorders()
        firstView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func secondTapped(_ sender: Any) {
        setBorders()
        secondView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func thirdTapped(_ sender: Any) {
        setBorders()
        thirdView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func forthTapped(_ sender: Any) {
        setBorders()
        forthView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
    }
    
    @IBAction func fifthTapped(_ sender: Any) {
        setBorders()
        fifthView.layer.borderColor = CGColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
        isCorrectTime = true
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CornViewController") as! CornViewController
        vc.isCorrectFilm = self.isCorrectFilm
        vc.isCorrectSeat = self.isCorrectSeat
        vc.isCorrectTime = self.isCorrectTime
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
