//
//  CoronaViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 07.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class CoronaViewController: UIViewController {
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    var isChecked = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    var nameDoctor = ""
    var room = ""
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var hospitalsTable: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK:-  CHECKBOXES
    
    @IBOutlet weak var check1: UIButton!
    @IBOutlet weak var check2: UIButton!
    @IBOutlet weak var check3: UIButton!
    @IBOutlet weak var check4: UIButton!
    @IBOutlet weak var check5: UIButton!
    @IBOutlet weak var check6: UIButton!
    @IBOutlet weak var check7: UIButton!
    @IBOutlet weak var check8: UIButton!
    @IBOutlet weak var check9: UIButton!
    @IBOutlet weak var check10: UIButton!
    @IBOutlet weak var check11: UIButton!
    @IBOutlet weak var check12: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        hospitalsTable.isHidden = true
        hospitalsTable.delegate = self
        hospitalsTable.dataSource = self
        nextButton.layer.cornerRadius = 10
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
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
        hospitalsTable.isHidden = !hospitalsTable.isHidden
    }
    
    
    //MARK:- CHECKBOXES TAPPED
    
    @IBAction func check1Tapped(_ sender: Any) {
        check1.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[0] = true
    }
    
    @IBAction func check2Tapped(_ sender: Any) {
        check2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[1] = true
    }
    
    @IBAction func check3Tapped(_ sender: Any) {
        check3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[2] = true
    }
    
    @IBAction func check4Tapped(_ sender: Any) {
        check4.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[3] = true
    }
    
    @IBAction func check5Tapped(_ sender: Any) {
        check5.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[4] = true
    }
    
    @IBAction func check6Tapped(_ sender: Any) {
        check6.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[5] = true
    }
    
    @IBAction func check7Tapped(_ sender: Any) {
        check7.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[6] = true
    }
    
    @IBAction func check8Tapped(_ sender: Any) {
        check8.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[7] = true
    }
    
    @IBAction func check9Tapped(_ sender: Any) {
        check9.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[8] = true
    }
    
    @IBAction func check10Tapped(_ sender: Any) {
        check10.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[9] = true
    }
    
    @IBAction func check11Tapped(_ sender: Any) {
        check11.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[10] = true
    }
    
    @IBAction func check12Tapped(_ sender: Any) {
        check12.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        hospitalsTable.isHidden = true
        isChecked[11] = true
    }
    
    //MARK:- NEXT TAP
    
    @IBAction func nextTapped(_ sender: Any) {
        if !isChecked.contains(false) {
           let vc = storyboard?.instantiateViewController(withIdentifier: "DateHospitalViewController") as! DateHospitalViewController
            vc.nameDoctor = self.nameDoctor
            vc.room = self.room
           self.navigationController?.pushViewController(vc, animated: false)
        } 
    }
}

extension CoronaViewController: UITableViewDelegate, UITableViewDataSource {
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
            self.navigationController?.popViewController(animated: false)
        }
    }
}
