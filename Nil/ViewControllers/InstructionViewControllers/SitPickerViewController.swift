//
//  SitPickerViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 24.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class SitPickerViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var forthView: UIView!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var sixthView: UIView!
    @IBOutlet weak var seventhView: UIView!
    @IBOutlet weak var adView: UIView!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var seatLabel: UILabel!
    
    var isReadyToNext = false
    var isCorrectFilm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        //setView()
    }
    
    private func setView(){
        adView.isHidden = true
        isReadyToNext = false
        secondView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        seatLabel.alpha = 0
        nextButton.layer.cornerRadius = 11
        firstView.layer.cornerRadius = 10
        secondView.layer.cornerRadius = 10
        thirdView.layer.cornerRadius = 10
        forthView.layer.cornerRadius = 10
        fifthView.layer.cornerRadius = 10
        sixthView.layer.cornerRadius = 10
        seventhView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
    }
    
    @IBAction func adCloseTapped(_ sender: Any) {
        adView.isHidden = true
    }
    
    
    override var prefersStatusBarHidden: Bool {return true}
    
    @IBAction func firstViewTapped(_ sender: Any) {
        adView.isHidden = false
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "10A"
            firstView.backgroundColor = UIColor(red: 252/255, green: 117/255, blue: 117/255, alpha: 1)
            UIView.animate(withDuration: 1) {
                self.firstView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.7)
                self.seatLabel.alpha = 0
            }
        }
    }
    
    @IBAction func secondViewTapped(_ sender: Any) {
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "10B"
            secondView.backgroundColor = UIColor(red: 0, green: 206/255, blue: 169/255, alpha: 1)
            isReadyToNext = true
        }
    }
    
    @IBAction func thirdViewTapped(_ sender: Any) {
        adView.isHidden = false
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "10C"
            thirdView.backgroundColor = UIColor(red: 252/255, green: 117/255, blue: 117/255, alpha: 1)
            UIView.animate(withDuration: 1) {
                self.thirdView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.7)
                self.seatLabel.alpha = 0
            }
        }
    }
    
    @IBAction func forthViewTapped(_ sender: Any) {
        adView.isHidden = false
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "9A"
            forthView.backgroundColor = UIColor(red: 252/255, green: 117/255, blue: 117/255, alpha: 1)
            UIView.animate(withDuration: 1) {
                self.forthView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.7)
                self.seatLabel.alpha = 0
            }
        }
    }
    
    @IBAction func fifthViewTapped(_ sender: Any) {
        adView.isHidden = false
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "9B"
            fifthView.backgroundColor = UIColor(red: 252/255, green: 117/255, blue: 117/255, alpha: 1)
            UIView.animate(withDuration: 1) {
                self.fifthView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.7)
                self.seatLabel.alpha = 0
            }
        }
    }
    
    @IBAction func sixthViewTapped(_ sender: Any) {
        adView.isHidden = false
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "9C"
            sixthView.backgroundColor = UIColor(red: 252/255, green: 117/255, blue: 117/255, alpha: 1)
            UIView.animate(withDuration: 1) {
                self.sixthView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.7)
                self.seatLabel.alpha = 0
            }
        }
    }
    
    @IBAction func seventhViewTapped(_ sender: Any) {
        adView.isHidden = false
        if !isReadyToNext {
            seatLabel.alpha = 1
            seatLabel.text = "8B"
            seventhView.backgroundColor = UIColor(red: 252/255, green: 117/255, blue: 117/255, alpha: 1)
            UIView.animate(withDuration: 1) {
                self.seventhView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.7)
                self.seatLabel.alpha = 0
            }
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        if isReadyToNext {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SeatAgreeViewController") as! SeatAgreeViewController
            vc.isCorretFilm = self.isCorrectFilm
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
