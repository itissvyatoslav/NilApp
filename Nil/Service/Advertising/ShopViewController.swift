//
//  ShopViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 02.12.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit

protocol ShopViewControllerDelegate {
    func cameFromMissing()
}

protocol ShopViewControllerHelpDelegate {
    func cameFromHelp()
}

class ShopViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var miniLabel: UILabel!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var restoreButton: UIButton!
    
    var delegate: ShopViewControllerDelegate?
    var delegateHelp: ShopViewControllerHelpDelegate?
    
    var idVC = 0
    
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
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
        noView.layer.cornerRadius = 23.5
        noButton.layer.cornerRadius = 23.5
        yesView.layer.cornerRadius = 23.5
        yesButton.layer.cornerRadius = 23.5
        bigView.layer.cornerRadius = 30
        bigView.clipsToBounds = true
        restoreButton.layer.cornerRadius = 18
        restoreButton.isHidden = true
        if idVC == 0 {
            mainLabel.text = "Подсказка"
            miniLabel.text = "Хочешь посмотреть видео и получить подсказку?"
        }
        if idVC == 1 {
            restoreButton.isHidden = false
            mainLabel.text = "Отключить рекламу"
            miniLabel.text = "Хочешь навсегда отключить рекламу за 179₽?"
        }
        if idVC == 2 {
            mainLabel.text = "Открыть уровень"
            miniLabel.text = "Хочешь посмотреть видео и открыть уровень раньше?"
        }
        print(areAdsDeleted)
    }
    
    override var prefersStatusBarHidden: Bool { return true}
    
    //MARK:- ACTIONS
    
    @IBAction func restoreTapped(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    var areAdsDeleted = UserDefaults.standard.bool(forKey: "areAdsDeleted")
    
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
            if SKPaymentQueue.canMakePayments() {
                let payment = SKPayment(product: model[0])
                SKPaymentQueue.default().add(self)
                SKPaymentQueue.default().add(payment)
            }
        }
        if idVC == 2 {
            if rewardedAd?.isReady == true {
                rewardedAd?.present(fromRootViewController: self, delegate:self)
            }
        }
    }
    
    @IBAction func noTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    //MARK:- IAP
    
    var myProduct: SKProduct?
    
    func fetchProduct(){
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    
    
    enum Product: String, CaseIterable {
        case buy = "nil.noads"
    }
    
    var model = [SKProduct]()
}

extension ShopViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        self.model = response.products
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased, .restored:
                UserDefaults.standard.set(true, forKey: "areAdsDeleted")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                self.navigationController?.popViewController(animated: false)
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
            default:
                break
            }
        }
    }
    
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    func purchaseMyProduct(product: SKProduct) {
        
    }
}

extension ShopViewController: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        if idVC == 0 {
            delegateHelp?.cameFromHelp()
            print("Reward received with currency: \(reward.type), amount \(reward.amount).")
            self.navigationController?.popViewController(animated: false)
        }
        if idVC == 2 {
            delegate?.cameFromMissing()
            self.navigationController?.popViewController(animated: false)
        }
    }
}
