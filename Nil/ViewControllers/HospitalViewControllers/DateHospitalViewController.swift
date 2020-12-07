//
//  DateHospitalViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 07.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class DateHospitalViewController: UIViewController {
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    var dates = [String]()
    let times = ["12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00"]
    var isMale = false
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var hospitalsTable: UITableView!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTable: UITableView!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeTable: UITableView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var FTickButton: UIButton!
    @IBOutlet weak var MTickButton: UIButton!
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
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
    
    
    var nameDoctor = ""
    var room = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        getDates()
        shopView.layer.cornerRadius = 20
        timeTable.isHidden = true
        hospitalsTable.isHidden = true
        dateTable.isHidden = true
        timeTable.delegate = self
        timeTable.dataSource = self
        hospitalsTable.delegate = self
        hospitalsTable.dataSource = self
        dateTable.delegate = self
        dateTable.dataSource = self
        nameTF.delegate = self
        dateTF.delegate = self
        phoneTF.delegate = self
        emailTF.delegate = self
        nextButton.layer.cornerRadius = 10
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    //MARK:- TOP BUTTONS ACTION
    
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
    
    @IBAction func doctorsTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func receptionTapped(_ sender: Any) {
        timeTable.isHidden = true
        dateTable.isHidden = true
        hospitalsTable.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.hospitalsTable.isHidden = true
        })
    }
    
    //MARK:- ANOTHER ACTIONS
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FinishHospitalViewController") as! FinishHospitalViewController
        vc.isMale = self.isMale
        vc.doctorName = self.nameDoctor
        vc.room = self.room
        vc.date = dateLabel.text ?? ""
        vc.time = timeLabel.text ?? ""
        vc.name = nameTF.text ?? ""
        vc.birthday = dateTF.text ?? ""
        vc.phone = phoneTF.text ?? ""
        vc.email = emailTF.text ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        dateTable.isHidden = !dateTable.isHidden
        timeTable.isHidden = true
        hospitalsTable.isHidden = true
    }
    
    @IBAction func timeTapped(_ sender: Any) {
        timeTable.isHidden = !timeTable.isHidden
        dateTable.isHidden = true
        hospitalsTable.isHidden = true
    }
    
    @IBAction func femaleCheckTapped(_ sender: Any) {
        FTickButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        MTickButton.setImage(UIImage(systemName: "square"), for: .normal)
        isMale = false
    }
    
    @IBAction func maleCheckTapped(_ sender: Any) {
        FTickButton.setImage(UIImage(systemName: "square"), for: .normal)
        MTickButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        isMale = true
    }
    
    private func getDates(){
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        dates.append("\(day).\(month).\(year)")
        let nextCalendar = Calendar.current.date(byAdding: .day, value: +1, to: date)
        let nextDay = calendar.component(.day, from: nextCalendar!)
        let nextMonth = calendar.component(.month, from: nextCalendar!)
        let nextYear = calendar.component(.year, from: nextCalendar!)
        dates.append("\(nextDay).\(nextMonth).\(nextYear)")
        let nextNextCalendar = Calendar.current.date(byAdding: .day, value: +2, to: date)
        let nextNextDay = calendar.component(.day, from: nextNextCalendar!)
        let nextNextMonth = calendar.component(.month, from: nextNextCalendar!)
        let nextNextYear = calendar.component(.year, from: nextNextCalendar!)
        dates.append("\(nextNextDay).\(nextNextMonth).\(nextNextYear)")
        let nextNextNextCalendar = Calendar.current.date(byAdding: .day, value: +3, to: date)
        let nextNextNextDay = calendar.component(.day, from: nextNextNextCalendar!)
        let nextNextNextMonth = calendar.component(.month, from: nextNextNextCalendar!)
        let nextNextNextYear = calendar.component(.year, from: nextNextNextCalendar!)
        dates.append("\(nextNextNextDay).\(nextNextNextMonth).\(nextNextNextYear)")
    }
}

extension DateHospitalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == hospitalsTable {
            return hospitals.count
        } else if tableView == dateTable {
            return dates.count
        } else if tableView == timeTable {
            return times.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hospitalsTable {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "hospitalCell")
            cell.textLabel?.text = hospitals[indexPath.row]
            cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
            return cell
        } else if tableView == dateTable {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "dateCell")
            cell.textLabel?.text = dates[indexPath.row]
            cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
            return cell
        } else if tableView == timeTable {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "timeCell")
            cell.textLabel?.text = times[indexPath.row]
            cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "e")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == hospitalsTable {
           if indexPath.row == 2 {
            self.navigationController?.popViewControllers(viewsToPop: 2, animated: false)
           }
        } else if tableView == dateTable {
            dateLabel.text = dates[indexPath.row]
            dateTable.isHidden = true
        } else if tableView == timeTable {
            timeLabel.text = times[indexPath.row]
            timeTable.isHidden = true
        }
    }
    
}
