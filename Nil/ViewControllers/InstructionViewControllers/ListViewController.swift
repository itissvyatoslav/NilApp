//
//  ListViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 26.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var image6: UIImageView!
    
    var isCorrectFilm = false
    var isCorrectSeat = false
    var isCorrectTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        startAnimation()
        goButton.layer.cornerRadius = 11
    }
    
    private func startAnimation() {
        goButton.alpha = 0
        labelOne.alpha = 0
        label2.alpha = 0
        image2.alpha = 0
        label3.alpha = 0
        image3.alpha = 0
        label4.alpha = 0
        image4.alpha = 0
        label5.alpha = 0
        image5.alpha = 0
        label6.alpha = 0
        image6.alpha = 0
        UIView.animate(withDuration: 1) { [self] in
            labelOne.alpha = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                UIView.animate(withDuration: 1) { [self] in
                    label2.alpha = 1
                    image2.alpha = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    UIView.animate(withDuration: 1) { [self] in
                        label3.alpha = 1
                        image3.alpha = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        UIView.animate(withDuration: 1) { [self] in
                            label4.alpha = 1
                            image4.alpha = 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            UIView.animate(withDuration: 1) { [self] in
                                label5.alpha = 1
                                image5.alpha = 1
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                UIView.animate(withDuration: 1) { [self] in
                                    label6.alpha = 1
                                    image6.alpha = 1
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                                    UIView.animate(withDuration: 1) { [self] in
                                        goButton.alpha = 1
                                    }
                                })
                            })
                        })
                    })
                })
            })
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func goTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "firstEnter")
        if isCorrectFilm && isCorrectSeat && isCorrectTime {
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
    
}
