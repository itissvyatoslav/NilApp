//
//  ConfirmPaymentViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class ConfirmPaymentViewController: UIViewController {
    
    var toPhone = false
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var newBalance: UILabel!
    @IBOutlet weak var summLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newSummLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var firstAgreeButton: UIButton!
    @IBOutlet weak var secondAgreeButton: UIButton!
    @IBOutlet weak var tickButton: UIButton!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    
    
    
    @IBOutlet weak var commentTF: UITextField!
    
    var cardSumm = 0
    var cardNumber = ""
    
    var contactName = ""
    var contactPhone = ""
    var newSumm = 0
    var transaction: Double = 0
    var summ = 0
    var isTicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView(){
        moneyLabel.text = "\(cardSumm) ₽"
        numbersLabel.text = cardNumber
        commentTF.delegate = self
        tickButton.isHidden = true
        firstAgreeButton.alpha = 0
        secondAgreeButton.alpha = 0
        let newBalanceSumm = round(Double(summ) / 0.01) * 0.01
        newBalance.text = "\(Double(cardSumm) - newBalanceSumm) ₽"
        summLabel.text = "-\(newBalanceSumm) ₽"
        phoneLabel.text = contactPhone
        transaction = Double(summ) - newSumm(newBalanceSumm)
        newSummLabel.text = "+ \(transaction) ₽"
        nameLabel.text = contactName
        cardView.layer.cornerRadius = 20
        bannerView.layer.cornerRadius = 20
        nextButton.layer.cornerRadius = 11
        descrLabel.text = "Нажимая “Перевести” вы соглашаетесь\nс условиями перевода. Комиссия может\nвзиматься  какая угодно, по желанию банка."
    }
    
    private func newSumm(_ summ: Double) -> Double {
        return ceil(summ * 0.02 + pow(summ, 1.2) * 0.0001 + pow(summ, 1.5) * 0.000001)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewControllers(viewsToPop: 5)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        if isTicked {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FinishBankViewController") as! FinishBankViewController
            vc.toPhone = self.toPhone
            vc.contactName = self.contactName
            vc.contactPhone = self.contactPhone
            vc.oldSumm = cardSumm
            vc.cardNumber = self.cardNumber
            vc.newSumm = Double(cardSumm - summ)
            vc.transactionSumm = transaction
            vc.summ = Double(summ)
            vc.comment = commentTF.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
        }
    }
    
    @IBAction func agreementTapped(_ sender: Any) {
         let vc = storyboard?.instantiateViewController(withIdentifier: "AgreementViewController") as! AgreementViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func bottomButton(_ sender: Any) {
        nextButton.alpha = 0
        firstAgreeButton.alpha = 1
        secondAgreeButton.alpha = 1
    }
}

extension ConfirmPaymentViewController: AgreementDelegate {
    func agreeAction() {
        isTicked = true
        tickButton.isHidden = false
        firstAgreeButton.isHidden = true
        UIView.animate(withDuration: 1) {
            self.tickButton.alpha = 0
            self.secondAgreeButton.alpha = 0
            self.nextButton.alpha = 1
        }
        UIView.animate(withDuration: 1) {
            self.nextButton.alpha = 1
        }
    }
}
