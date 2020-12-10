//
//  MainBankViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

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
    
    struct Helper {
        var title: String
        var from: String
        var text: String
    }
    
    let helpers = [Helper(title: "Сообщение", from: "Сынок", text: "Пап, телефон сломался. Он перестал переворачиваться"), Helper(title: "Сообщение", from: "Катя ❤️", text: "Папа, мой счет почему-то заблокировали, посмотри пожалуйста"), Helper(title: "Новости", from: "Новостья дня!", text: "Доллар достиг своего пика за последний год"), Helper(title: "DeZigner", from: "Подсказка", text: "Попробуйте сделать свайп на вашем счете"), Helper(title: "Банк", from: "Обновление", text: "Теперь вы можете делать переводы на карту по телефону")]
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    
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
    
    
    
    let areAdsDeleted = UserDefaults.standard.bool(forKey: "areAdsDeleted")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
        setTable()
        interstitial = createAndLoadInterstitial()
        messageView.alpha = 0
        messageView.layer.cornerRadius = 20
        messageView.center.y -= 90
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
    
    @objc override func didSwipedRight() {
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
    
    
    //MARK:- SHOW AD
    
    var interstitial: GADInterstitial!
    
    func createAndLoadInterstitial() -> GADInterstitial {
      var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
      interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
    }
    
    @IBAction func fristMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func secondMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
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
            } else if indexPath.row == 2 {
                areCardsSelecting = false
                selectedSummDollar = summsDollars[1]
                selectedSummRub = summs[1]
                moneyLabel.text = "\(summsDollars[1]) $"
                secondMoneyLabel.text = "\(summs[1]) ₽"
                cardNumberLabel.text = numbersCard[1]
                tableView.reloadData()
            } else if indexPath.row == 3 {
                selectedSummDollar = summsDollars[2]
                selectedSummRub = summs[2]
                areCardsSelecting = false
                moneyLabel.text = "\(summsDollars[2]) $"
                secondMoneyLabel.text = "\(summs[2]) ₽"
                cardNumberLabel.text = numbersCard[2]
                tableView.reloadData()
            } else if indexPath.row == 9 {
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
            } else if indexPath.row == 10 {
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
            } else if indexPath.row == 0{
                
            } else {
                if !areAdsDeleted {
                    if interstitial.isReady {
                        interstitial.present(fromRootViewController: self)
                    }
                }
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
            } else if indexPath.row == 7 {
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
            } else if indexPath.row == 0{
            } else {
                if !areAdsDeleted {
                    if interstitial.isReady {
                        interstitial.present(fromRootViewController: self)
                    }
                }
            }
        }
    }
}

extension MainBankViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
}

extension MainBankViewController: ShopViewControllerHelpDelegate {
    func cameFromHelp() {
        let number = Int.random(in: 0...helpers.count - 1)
        titleLabel.text = helpers[number].title
        fromLabel.text = helpers[number].from
        textLabel.text = helpers[number].text
        messageView.alpha = 1
        startMusicPush()
        UIView.animate(withDuration: 1) {
            self.messageView.center.y += 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
            UIView.animate(withDuration: 1) {
                self.messageView.center.y -= 180
            }
        })
    }
}
