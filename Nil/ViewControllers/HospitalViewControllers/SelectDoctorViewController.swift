//
//  SelectDoctorViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 06.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SelectDoctorViewController: UIViewController, GADInterstitialDelegate {
    
    struct Helper {
        var title: String
        var from: String
        var text: String
    }
    
    let helpers = [Helper(title: "Сообщение", from: "Лера, жена", text: "Оказывается у них нет соответствия врача и кабинета.. Что с ними не так"), Helper(title: "DeZigner", from: "Подсказка", text: "Выберите нужного врача и кабинет")]
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    let rooms = ["каб. 402", "каб. 407", "каб. 409", "каб. 303", "каб. 301", "каб. 101", "каб. 101б", "каб. 190", "каб. 204", "каб. 204", "каб. 199", "каб. 103", "каб. 128", "каб. 510", "каб. 445", "каб. 439", "каб. 10", "каб. 12", "каб. 221б"]
    let names = ["Мамонтова Галина Фёдоровна", "Светикова Полина Александровна", "Иванов Фёдор Петрович", "Лоликова Светлана Иоановна", "Кусь Марина Ивановна", "Атаманова Анна Артуровна", "Иванов Пётр Петрович", "Ларина Полина Петровна", "Славина Ирина Ильинична", "Лев Светлана Львовна", "Иванов Фёдор Петрович", "Сельвина Инна Викторовна", "Грегори Хаус", "Лесина Анна Валентиновна", "Сайдапов Анатолий Георгиевич", "Василенко Ирина Анатольевна", "Вершинина Вера Петровна", "Епареев Сергей Васильевич", "Репина Александра Владимировна", "Борисов Николай Иванович", "Кулибин Аркадий Валерьевич", "Кручинин Халипат Владимирович ", "Белокрылова Добрица Артемовна", "Пименова Дашута Яковлевна", "Стивен Винсент Стрэндж", "Смирнова Ритина Филипповна", "Белозёров Максим Максимович", "Ильина Рамония Дмитриевна", "Голубев Томилослав Владимирович", "Минаев Павел Геннадиевич", "Ургин Валерий Петрович", "Васильев Петр Александрович", "Петрова Юлия Владимировна", "Беренцев Владимир Сергеевич", "Ципка Илья Александрович", "Джон Хэмиш Ватсон", "Кусанов Альберт Тимурович", "Бережков Сергей Ианович", "Тропинка Олеся Тимофеевна", "Дюбина Мария Алексеевна", "Неальпова Надежда Андреевна", "Попкова Дарья Владимировна", "Перечкина Инна Аркадьевна", "Лешенко Инга Павловна", "Каримова Вероника Николаевна"]
    
    //MARK:- OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTable: UITableView!
    
    @IBOutlet weak var roomTable: UITableView!
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var hospitalsTable: UITableView!
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
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
        messageView.alpha = 0
        messageView.layer.cornerRadius = 20
        messageView.center.y -= 90
        super.viewDidLoad()
        hideNavigationBar()
        shopView.layer.cornerRadius = 20
        roomTable.isHidden = true
        roomTable.delegate = self
        roomTable.dataSource = self
        nameTable.isHidden = true
        nameTable.delegate = self
        nameTable.dataSource = self
        hospitalsTable.isHidden = true
        hospitalsTable.delegate = self
        hospitalsTable.dataSource = self
        nextButton.layer.cornerRadius = 10
        interstitial = createAndLoadInterstitial()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    
    // MARK: - TOP BUTTONS ACTION
    
    @IBAction func mainTapped(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as
            Array {
                if controller.isKind(of:
                    MainHospitalViewController.self) {
                    _ =
                        self.navigationController!.popToViewController(controller,
                                                                       animated: false)
                    break
                }
        }

    }
    
    @IBAction func receptionTapped(_ sender: Any) {
        
        roomTable.isHidden = true
        nameTable.isHidden = true
        hospitalsTable.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.hospitalsTable.isHidden = true
        })
    }
    
    @IBAction func doctorsTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CoronaViewController") as! CoronaViewController
        vc.nameDoctor = nameLabel.text ?? ""
        vc.room = roomLabel.text ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK:- SHOW AD
    
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
    
    @IBAction func firstMissAction(_ sender: Any) {
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
    
    @IBAction func thirdMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func forthMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func fifthMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    @IBAction func sixthMissAction(_ sender: Any) {
        if !areAdsDeleted {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    //MARK:- VIEW BUTTONS
    
    @IBAction func nameTapped(_ sender: Any) {
        nameTable.isHidden = !nameTable.isHidden
        roomTable.isHidden = true
        hospitalsTable.isHidden = true
    }
    
    @IBAction func roomTapped(_ sender: Any) {
        roomTable.isHidden = !roomTable.isHidden
        nameTable.isHidden = true
        hospitalsTable.isHidden = true
    }
}

extension SelectDoctorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == roomTable {
            return rooms.count
        } else if tableView == nameTable {
            return names.count
        } else if tableView == hospitalsTable {
            return hospitals.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == roomTable {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "roomCell")
            cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
            cell.textLabel?.text = rooms[indexPath.row]
            return cell
        } else if tableView == nameTable {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "nameCell")
            cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
            cell.textLabel?.text = names[indexPath.row]
            return cell
        } else if tableView == hospitalsTable {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "hospitalCell")
            cell.textLabel?.text = hospitals[indexPath.row]
            cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "e")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == roomTable {
            roomLabel.text = rooms[indexPath.row]
            roomTable.isHidden = true
        } else if tableView == nameTable {
            nameLabel.text = names[indexPath.row]
            nameTable.isHidden = true
        } else if tableView == hospitalsTable {
            if indexPath.row == 2 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "SelectDoctorViewController") as! SelectDoctorViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
}

extension SelectDoctorViewController: ShopViewControllerHelpDelegate {
    func cameFromHelp() {
        let number = Int.random(in: 0...helpers.count - 1)
        titleLabel.text = helpers[number].title
        fromLabel.text = helpers[number].from
        textLabel.text = helpers[number].text
        messageView.alpha = 1
        startMusicPush()
        UIView.animate(withDuration: 1) {
            self.messageView.center.y += 10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
            UIView.animate(withDuration: 1) {
                self.messageView.center.y -= 180
            }
        })
    }
}
