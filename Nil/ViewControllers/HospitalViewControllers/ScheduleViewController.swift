//
//  ScheduleViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 06.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ScheduleViewController: UIViewController, GADInterstitialDelegate {
    
    let hospitals = ["ГБУЗ №3", "ГКБ №121", "ГП №11", "ГКБСМП №21", "ГКП №1", "ГИК №2", "ЦКБ №2"]
    
    struct Helper {
        var title: String
        var from: String
        var text: String
    }
    
    let helpers = [Helper(title: "DeZigner", from: "Подсказка", text: "Найдите нужную информацию")]
    
    @IBOutlet weak var hospitalsTable: UITableView!
    @IBOutlet weak var shopView: UIView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    //@IBOutlet weak var shopLabel: UILabel!
    
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
        hospitalsTable.isHidden = true
        hospitalsTable.delegate = self
        hospitalsTable.dataSource = self
        interstitial = createAndLoadInterstitial()
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
        
        hospitalsTable.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.hospitalsTable.isHidden = true
        })
    }
    
    @IBAction func doctorsTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
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
}

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
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

extension ScheduleViewController: ShopViewControllerHelpDelegate {
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
