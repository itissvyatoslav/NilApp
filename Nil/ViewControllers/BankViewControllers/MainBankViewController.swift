//
//  MainBankViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class MainBankViewController: UIViewController {
    
    enum CardsCurrency {
        case ruble
        case dollar
    }
    
    var isRub = false
    
    var selectedSumm = 94000
    var selectedSummRub = 94000
    var selectedSummDollar = 0
    var selectedCard = CardsCurrency.dollar
    
    var areCardsSelecting = false
    
    let menuLabels = ["Счета", "Вклады", "Кредиты", "Переводы", "Инфо", "Коммунальные услуги", "Переводы по телефону", "Перевод на телефон"]
    let menuWithSelectingCards = ["Счета", "Зарплата", "Катя", "Лера", "Вклады", "Кредиты", "Переводы", "Инфо", "Коммунальные услуги", "Переводы по телефону", "Перевод на телефон"]
    
    let menuImages = [UIImage(named: "0"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7")]
    
    let numbersCard = ["**** 4523", "**** 4519", "**** 4591"]
    let summs = [94000, 1600, 45000]
    let summsDollars = [140, 0, 800]
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var secondCardView: UIView!
    
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var secondMoneyLabel: UILabel!
    @IBOutlet weak var secondCardNumberLabel: UILabel!
    
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        setTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
    
    private func setView() {
        shopView.layer.cornerRadius = 20
        moneyLabel.text = "140 $"
        secondMoneyLabel.text = "94000 ₽"
        firstLabel.text = "Сезонное предложение:\nоткрой 2 кредита и получи 3ий"
        secondLabel.text = "Вы всё еще тратите деньги с\nдебетовой карты? Хватит!"
        secondCardView.layer.cornerRadius = 20
        cardView.layer.cornerRadius = 20
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.cardView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.secondCardView.addGestureRecognizer(swipeRight)
    }
    
    @objc func didSwipedLeft() {
        isRub = true
        selectedCard = CardsCurrency.ruble
        print("left")
        UIView.animate(withDuration: 0.5) {
            self.cardView.center.x -= UIScreen.main.bounds.width
            self.secondCardView.center.x -= UIScreen.main.bounds.width
        }
    }
    
    @objc func didSwipedRight() {
        isRub = false
        selectedCard = CardsCurrency.dollar
        print("right")
        UIView.animate(withDuration: 0.5) {
            self.cardView.center.x += UIScreen.main.bounds.width
            self.secondCardView.center.x += UIScreen.main.bounds.width
        }
    }
    
    private func setTable() {
        self.menuTable.register(UINib(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "MainTableCell")
        self.menuTable.register(UINib(nibName: "CardTableCell", bundle: nil), forCellReuseIdentifier: "CardTableCell")
        menuTable.backgroundColor = UIColor.black
        menuTable.delegate = self
        menuTable.dataSource = self
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func setLights() {
        let numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights != 500 {
            //shopLabel.text = "\(numberLights)"
        } else {
            //shopLabel.text = "∞"
        }
    }
    
    @IBAction func shopTapped(_ sender: Any) {
        var numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } else if numberLights == 500 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            numberLights -= 1
            UserDefaults.standard.set(numberLights, forKey: "lights")
            //shopLabel.text = "\(numberLights)"
        }
    }
    
    
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
                print("\(indexPath.row) is selecting")
                areCardsSelecting = false
                selectedSummDollar = summsDollars[0]
                selectedSummRub = summs[0]
                moneyLabel.text = "\(summsDollars[0]) $"
                secondMoneyLabel.text = "\(summs[0]) ₽" 
                cardNumberLabel.text = numbersCard[0]
                tableView.reloadData()
            }
            
            if indexPath.row == 2 {
                areCardsSelecting = false
                selectedSummDollar = summsDollars[1]
                selectedSummRub = summs[1]
                moneyLabel.text = "\(summsDollars[1]) $"
                secondMoneyLabel.text = "\(summs[1]) ₽"
                cardNumberLabel.text = numbersCard[1]
                tableView.reloadData()
            }
            
            if indexPath.row == 3 {
                selectedSummDollar = summsDollars[2]
                selectedSummRub = summs[2]
                areCardsSelecting = false
                moneyLabel.text = "\(summsDollars[2]) $"
                secondMoneyLabel.text = "\(summs[2]) ₽"
                cardNumberLabel.text = numbersCard[2]
                tableView.reloadData()
            }
            
            if indexPath.row == 9 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                if isRub {
                    selectedSumm = selectedSummRub
                } else {
                    selectedSumm = selectedSummDollar
                }
                vc.isRub = self.isRub
                vc.cardSumm = selectedSumm
                vc.cardNumber = cardNumberLabel.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 10 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                if isRub {
                    selectedSumm = selectedSummRub
                } else {
                    selectedSumm = selectedSummDollar
                }
                vc.isRub = self.isRub
                vc.cardSumm = selectedSumm
                vc.cardNumber = cardNumberLabel.text ?? ""
                vc.toPhone = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            secondCardNumberLabel.text = cardNumberLabel.text
        } else {
            if indexPath.row == 6 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                if isRub {
                    selectedSumm = selectedSummRub
                } else {
                    selectedSumm = selectedSummDollar
                }
                vc.isRub = self.isRub
                vc.cardSumm = selectedSumm
                vc.cardNumber = cardNumberLabel.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 7 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
                if isRub {
                    selectedSumm = selectedSummRub
                } else {
                    selectedSumm = selectedSummDollar
                }
                vc.isRub = self.isRub
                vc.cardSumm = selectedSumm
                vc.cardNumber = cardNumberLabel.text ?? ""
                vc.toPhone = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
}
