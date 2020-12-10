//
//  SecondBadViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 25.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SecondBadViewController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var restartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        restartButton.layer.cornerRadius = 11
        interstitial = createAndLoadInterstitial()
    }
    
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
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func restartAction(_ sender: Any) {
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
    
    @IBAction func laterTapped(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
}
