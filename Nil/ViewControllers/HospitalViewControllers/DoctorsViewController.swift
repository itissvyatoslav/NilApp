//
//  DoctorsViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 06.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class DoctorsViewController: UIViewController {
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    
    @IBOutlet weak var hospitalsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        hospitalsView.isHidden = true
        hospitalsView.delegate = self
        hospitalsView.dataSource = self
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    //MARK: - TOP BUTTONS TAPPED
    
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
        hospitalsView.isHidden = !hospitalsView.isHidden
    }
    
    @IBAction func scheduleTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension DoctorsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hospitalCell")
        cell.textLabel?.text = hospitals[indexPath.row]
        cell.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 214/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectDoctorViewController") as! SelectDoctorViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
