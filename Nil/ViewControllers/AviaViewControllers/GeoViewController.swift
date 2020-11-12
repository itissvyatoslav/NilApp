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
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var citiesView: UIView!
    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
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
        self.navigationController?.pushViewController(vc, animated: true)
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

