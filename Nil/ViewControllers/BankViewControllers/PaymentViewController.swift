//
//  PaymentViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    var toPhone = false
    
    var cardSumm = 0
    var cardNumber = ""
    
    var contactName = ""
    var contactPhone = ""
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var anotherCardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var summTF: UITextField!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var cardNumbersLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView(){
        moneyLabel.text = "\(cardSumm) ₽"
        cardNumbersLabel.text = cardNumber
        summTF.delegate = self
        nextButton.layer.cornerRadius = 11
        cardView.layer.cornerRadius = 20
        anotherCardView.layer.cornerRadius = 20
        downLabel.text = "Нажимая “Перевести” вы соглашаетесь\nс условиями перевода. Комиссия может\nвзиматься  какая угодно, по желанию банка."
        summTF.textColor = UIColor.white
        summTF.text = "0.00 ₽"
        nameLabel.text = contactName
        phoneLabel.text = contactPhone
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ConfirmPaymentViewController") as! ConfirmPaymentViewController
        vc.toPhone = self.toPhone
        vc.contactName = self.contactName
        vc.contactPhone = self.contactPhone
        vc.cardSumm = self.cardSumm
        vc.cardNumber = self.cardNumber
        if let summ = Int(summTF.text ?? "0") {
            vc.summ = summ
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewControllers(viewsToPop: 4)
    }
    
}
