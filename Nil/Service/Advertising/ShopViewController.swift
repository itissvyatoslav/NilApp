//
//  ShopViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 02.12.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ShopViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var miniLabel: UILabel!
    
    var idVC = 0
    
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3210886375348088/5365852066")
        rewardedAd?.load(GADRequest()) { error in
          if let error = error {
            // Handle ad failed to load case.
          } else {
            // Ad successfully loaded.
          }
        }
        //self.modalPresentationStyle = .overCurrentContext
    }
    
    private func setView(){
        //shopView.layer.cornerRadius = 30
        //closeView.layer.cornerRadius = 30
        bigView.layer.cornerRadius = 30
        bigView.clipsToBounds = true
        if idVC == 0 {
            miniLabel.text = "Хочешь посмотреть видео и получить подсказку?"
        }
        if idVC == 1 {
            miniLabel.text = "Хочешь навсегда отключить рекламу за 299₽?"
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true}
    
    //MARK:- ACTIONS
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func yesTapped(_ sender: Any) {
        if idVC == 0 {
            if rewardedAd?.isReady == true {
                   rewardedAd?.present(fromRootViewController: self, delegate:self)
                }
        }
        if idVC == 1 {
            
        }
    }
    
    @IBAction func noTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension ShopViewController: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        self.navigationController?.popViewController(animated: false)
    }
}
