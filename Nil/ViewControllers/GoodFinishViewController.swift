//
//  GoodFinishViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 07.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GoodFinishViewController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var finishButton: UIButton!
    
    var vcID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        finishButton.layer.cornerRadius = 11
        interstitial = createAndLoadInterstitial()
        finishTask()
    }
    
    let is0Finished = UserDefaults.standard.bool(forKey: "is0Finished")
    let is1Finished = UserDefaults.standard.bool(forKey: "is1Finished")
    let is2Finished = UserDefaults.standard.bool(forKey: "is2Finished")
    let is3Finished = UserDefaults.standard.bool(forKey: "is3Finished")
    
    private func finishTask() {
        if vcID == 0 {
            UserDefaults.standard.set(true, forKey: "is0Finished")
            if !is1Finished {
                UserDefaults.standard.set(Date().add(seconds: 15), forKey: "hospitalTimeOpen")
            }
        }
        if vcID == 1 {
            UserDefaults.standard.set(true, forKey: "is1Finished")
            if !is2Finished {
                UserDefaults.standard.set(Date().add(minutes: 30), forKey: "bankTimeOpen")
            }
        }
        if vcID == 2 {
            UserDefaults.standard.set(true, forKey: "is2Finished")
            if !is3Finished {
                UserDefaults.standard.set(Date().add(minutes: 30), forKey: "aviaTimeOpen")
            }
        }
        if vcID == 3 {
            UserDefaults.standard.set(true, forKey: "is3Finished")
        }
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
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
    
    @IBAction func blackButtonTapped(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func smallButtonTapped(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as
            Array {
                if controller.isKind(of:
                    MainMenuViewController.self) {
                    _ =
                        self.navigationController!.popToViewController(controller,
                                                                       animated: false)
                    break
                }
        }
    }
    
    
}
