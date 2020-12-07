//
//  SeatAgreeViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 26.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class SeatAgreeViewController: UIViewController {
    
    let seats = ["10A", "10B", "10C", "9A", "9B", "9C", "8B"]
    
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var seatView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var placesTable: UITableView!
    
    var isCorretFilm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView() {
        placesTable.isHidden = true
        seatView.layer.cornerRadius = 5
        placesTable.layer.cornerRadius = 5
        nextButton.layer.cornerRadius = 11
        placesTable.tableFooterView = UIView(frame: .zero)
        placesTable.delegate = self
        placesTable.dataSource = self
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func nextTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CinemaTimeViewController") as! CinemaTimeViewController
        if seatLabel.text == "10B" {
            vc.isCorrectSeat = true
        }
        vc.isCorrectFilm = self.isCorretFilm
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        placesTable.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.placesTable.isHidden = true
        })
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension SeatAgreeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SeatCell")
        cell.textLabel?.text = seats[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seatLabel.text = seats[indexPath.row]
        placesTable.isHidden = true
    }
}
