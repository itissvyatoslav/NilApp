//
//  MainBankViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class MainBankViewController: UIViewController {
    
    var selectedSumm = 94000
    
    var areCardsSelecting = false
    
    let menuLabels = ["Счета", "Вклады", "Кредиты", "Переводы", "Инфо", "Коммунальные услуги", "Переводы по телефону", "Перевод на телефон"]
    let menuWithSelectingCards = ["Счета", "Зарплата", "Катя", "Лера", "Вклады", "Кредиты", "Переводы", "Инфо", "Коммунальные услуги", "Переводы по телефону", "Перевод на телефон"]
    
    let menuImages = [UIImage(named: "0"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7")]
    
    let numbersCard = ["**** 4523", "**** 4519", "**** 4591"]
    let summs = [94000, 1600, 45000]
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        setTable()
    }
    
    private func setView() {
        moneyLabel.text = "94000 ₽"
        firstLabel.text = "Сезонное предложение:\nоткрой 2 кредита и получи 3ий"
        secondLabel.text = "Вы всё еще тратите деньги с\nдебетовой карты? Хватит!"
        cardView.layer.cornerRadius = 20
    }
    
    private func setTable() {
        self.menuTable.register(UINib(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "MainTableCell")
        self.menuTable.register(UINib(nibName: "CardTableCell", bundle: nil), forCellReuseIdentifier: "CardTableCell")
        menuTable.backgroundColor = UIColor.black
        menuTable.delegate = self
        menuTable.dataSource = self
    }
    
    override var prefersStatusBarHidden: Bool { return true }
}

extension MainBankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if areCardsSelecting {
            return menuWithSelectingCards.count
        } else {
            return menuLabels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if areCardsSelecting  {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell") as! MainTableCell
                cell.backgroundColor = UIColor.black
                cell.nameLabel.textColor = UIColor.white
                cell.nameLabel.text = menuLabels[indexPath.row]
                cell.miniImage.image = menuImages[indexPath.row]
                return cell
            } else if indexPath.row > 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell") as! MainTableCell
                cell.backgroundColor = UIColor.black
                cell.nameLabel.textColor = UIColor.white
                cell.nameLabel.text = menuLabels[indexPath.row - 3]
                cell.miniImage.image = menuImages[indexPath.row - 3]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableCell") as! CardTableCell
                cell.backgroundColor = UIColor.black
                cell.nameLabel.text = menuWithSelectingCards[indexPath.row]
                cell.numbersLabel.text = numbersCard[indexPath.row - 1]
                cell.separatorInset = .zero
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell") as! MainTableCell
            cell.backgroundColor = UIColor.black
            cell.nameLabel.textColor = UIColor.white
            cell.nameLabel.text = menuLabels[indexPath.row]
            cell.miniImage.image = menuImages[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            areCardsSelecting = !areCardsSelecting
            tableView.reloadData()
        }
        
        if areCardsSelecting {
            
            if indexPath.row == 1 {
                areCardsSelecting = false
                selectedSumm = summs[0]
                moneyLabel.text = "\(summs[0]) ₽"
                cardNumberLabel.text = numbersCard[0]
                tableView.reloadData()
            }
            
            if indexPath.row == 2 {
                areCardsSelecting = false
                selectedSumm = summs[1]
                moneyLabel.text = "\(summs[1]) ₽"
                cardNumberLabel.text = numbersCard[1]
                tableView.reloadData()
            }
            
            if indexPath.row == 3 {
                selectedSumm = summs[2]
                areCardsSelecting = false
                moneyLabel.text = "\(summs[2]) ₽"
                cardNumberLabel.text = numbersCard[2]
                tableView.reloadData()
            }
            
            if indexPath.row == 9 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                vc.cardSumm = Int(moneyLabel.text ?? "0") ?? 0
                vc.cardNumber = cardNumberLabel.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 10 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                vc.cardSumm = Int(moneyLabel.text ?? "0") ?? 0
                vc.cardNumber = cardNumberLabel.text ?? ""
                vc.toPhone = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if indexPath.row == 6 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                vc.cardSumm = selectedSumm
                vc.cardNumber = cardNumberLabel.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 7 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                vc.cardSumm = selectedSumm
                vc.cardNumber = cardNumberLabel.text ?? ""
                vc.toPhone = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
}
