//
//  MainHospitalViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 06.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class MainHospitalViewController: UIViewController {
    
    @IBOutlet weak var hospitalsView: UIView!
    @IBOutlet weak var hospitalTable: UITableView!
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        hospitalsView.isHidden = true
        hospitalTable.delegate = self
        hospitalTable.dataSource = self
    }
    
    //MARK:- TOP BUTTONS ACTIONS
    
    @IBAction func doctorsTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func receptionTapped(_ sender: Any) {
        hospitalsView.isHidden = !hospitalsView.isHidden
    }
    
    
    override var prefersStatusBarHidden: Bool { return true }
}

extension MainHospitalViewController: UITableViewDelegate, UITableViewDataSource {
    
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
