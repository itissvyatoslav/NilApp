//
//  SelectDoctorViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 06.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class SelectDoctorViewController: UIViewController {
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    let rooms = ["каб. 402", "каб. 407", "каб. 409"]
    let names = ["Мамонтова Галина Фёдоровна", "Светикова Полина Александровна", "Иванов Фёдор Петрович", "Лоликова Светлана Иоановна", "Кусь Марина Ивановна", "Атаманова Анна Артуровна", "Иванов Пётр Петрович", "Ларина Полина Петровна", "Славина Ирина Ильинична", "Лев Светлана Львовна", "Иванов Фёдор Петрович", "Сельвина Инна Викторовна"]
    
    //MARK:- OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTable: UITableView!
    
    @IBOutlet weak var roomTable: UITableView!
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var hospitalsTable: UITableView!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
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
        hospitalsTable.isHidden = !hospitalsTable.isHidden
        roomTable.isHidden = true
        nameTable.isHidden = true
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
