//
//  PaymentViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    var isRub = false
    
    var toPhone = false
    
    var cardSumm = 0
    var cardNumber = ""
    
    var contactName = ""
    var contactPhone = ""
    
    struct Helper {
        var title: String
        var from: String
        var text: String
    }
    
    let helpers = [Helper(title: "Банк", from: "Комиссия", text: "К сожалению мы не можем посчитать комиссию"), Helper(title: "DeZigner", from: "Подсказка", text: "Введите только число")]
    
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
    
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    @IBOutlet weak var shopTapped: UIButton!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!
    
    
    @IBAction func shopAction(_ sender: Any) {
        var numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            vc.delegateHelp = self
            self.navigationController?.pushViewController(vc, animated: false)
        } else if numberLights == 500 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            vc.delegateHelp = self
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            numberLights -= 1
            UserDefaults.standard.set(numberLights, forKey: "lights")
            //shopLabel.text = "\(numberLights)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
    
    private func setLights() {
        let numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights != 500 {
            //shopLabel.text = "\(numberLights)"
        } else {
            //shopLabel.text = "∞"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        messageView.alpha = 0
        messageView.layer.cornerRadius = 20
        messageView.center.y -= 90
    }
    
    private func setView(){
        shopView.layer.cornerRadius = 20
        if isRub {
            summTF.text = "0.00 ₽"
            moneyLabel.text = "\(cardSumm) ₽"
        } else {
            moneyLabel.text = "\(cardSumm) $"
            summTF.text = "0.00 $"
        }
        cardNumbersLabel.text = cardNumber
        summTF.delegate = self
        nextButton.layer.cornerRadius = 11
        cardView.layer.cornerRadius = 20
        anotherCardView.layer.cornerRadius = 20
        downLabel.text = "Нажимая “Перевести” вы соглашаетесь\nс условиями перевода. Комиссия может\nвзиматься  какая угодно, по желанию банка."
        summTF.textColor = UIColor.white
        
        nameLabel.text = contactName
        phoneLabel.text = contactPhone
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ConfirmPaymentViewController") as! ConfirmPaymentViewController
        vc.isRub = self.isRub
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

extension PaymentViewController: ShopViewControllerHelpDelegate {
    func cameFromHelp() {
        let number = Int.random(in: 0...helpers.count - 1)
        titleLabel.text = helpers[number].title
        fromLabel.text = helpers[number].from
        textlabel.text = helpers[number].text
        messageView.alpha = 1
        startMusicPush()
        UIView.animate(withDuration: 1) {
            self.messageView.center.y += 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
            UIView.animate(withDuration: 1) {
                self.messageView.center.y -= 180
                self.messageView.alpha = 0
            }
        })
       
    }
}
