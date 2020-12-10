//
//  GeoViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 30.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class GeoViewController: UIViewController {
    
    private let cities = ["Moscow", "Astana", "Nursultan", "Novosibirsk", "Saratov", "Cupertino", "Madagaskar", "New York", "Barselona", "Current location", "Close"]
    
    private var isFrom = false
    
    struct Helper {
        var title: String
        var from: String
        var text: String
    }
    
    let helpers = [Helper(title: "Сообщение", from: "Лера, жена", text: "Пришлось взять большой чемодан. Как там с билетами?"), Helper(title: "Погода", from: "Problems :(", text: "Sorry, but we can’t define your current location"), Helper(title: "Сообщение", from: "Сынок", text: "если что я закрылся на самый нижний замок"), Helper(title: "DeZigner", from: "Подсказка", text: "А что будет если нажать на багаж"), Helper(title: "DeZigner", from: "Подсказка", text: "Посмотрите на выпадающий список внимательнее")]

    
    //MARK:- OUTLETS
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var citiesView: UIView!
    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var shopView: UIView!
    //@IBOutlet weak var shopLabel: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromMessageLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        setLights()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setLights() {
        let numberLights = UserDefaults.standard.integer(forKey: "lights")
        if numberLights != 500 {
            //shopLabel.text = "\(numberLights)"
        } else {
            //shopLabel.text = "∞"
        }
    }
    
    private func setView(){
        messageView.alpha = 0
        messageView.layer.cornerRadius = 20
        messageView.center.y -= 90
        shopView.layer.cornerRadius = 20
        mainLabel.text = "Выберите откуда вас\nзабрать и куда доставить"
        checkBox.isHidden = true
        nextButton.layer.cornerRadius = 11
        citiesView.isHidden = true
        citiesTable.delegate = self
        citiesTable.dataSource = self
        citiesView.layer.shadowColor = UIColor.black.cgColor
        citiesView.layer.shadowOpacity = 0.3
        citiesView.layer.shadowOffset = .zero
        citiesView.layer.shadowRadius = 1
        hideNavigationBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK:- ACTION BUTTONS
    
    @IBAction func luggageTap(_ sender: Any) {
        checkBox.isHidden = !checkBox.isHidden
    }
    
    @IBAction func fromTapped(_ sender: Any) {
        citiesView.isHidden = false
        isFrom = true
    }
    
    @IBAction func toTapped(_ sender: Any) {
        citiesView.isHidden = false
        isFrom = false
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "DateViewController") as! DateViewController
        vc.fromCity = fromLabel.text ?? ""
        vc.toCity = toLabel.text ?? ""
        vc.isBuggage = !checkBox.isHidden
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    

}

extension GeoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "citiesCell")
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == cities.count - 1 {
            isFrom = false
            citiesView.isHidden = true
        } else {
            if isFrom {
                fromLabel.text = cities[indexPath.row]
            } else {
                toLabel.text = cities[indexPath.row]
            }
        }
    }
}

extension GeoViewController: ShopViewControllerHelpDelegate {
    func cameFromHelp() {
        let number = Int.random(in: 0...helpers.count - 1)
        titleLabel.text = helpers[number].title
        fromMessageLabel.text = helpers[number].from
        textLabel.text = helpers[number].text
        messageView.alpha = 1
        startMusicPush()
        UIView.animate(withDuration: 1) {
            self.messageView.center.y += 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
            UIView.animate(withDuration: 1) {
                self.messageView.center.y -= 180
                self.messageView.alpha = 0
            }
        })
       
    }
}
