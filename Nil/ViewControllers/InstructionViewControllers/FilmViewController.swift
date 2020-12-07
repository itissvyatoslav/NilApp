//
//  FilmViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 24.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController {
    
    var filmID = 0
    
    let films = ["Ля-ля-ла-Ленд\n(Романтика)", "Бензопила\n(Ужас)", "В Вегасе\n(Комедия)", "Медный человек\n(супергероика)", "Форсаж 82\n(боевик)"]
    let filmImages = [UIImage(named: "lala"), UIImage(named: "chain"), UIImage(named: "vegas"), UIImage(named: "iron"), UIImage(named: "furious")]

    
    @IBOutlet weak var filmLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var filmImageView: UIView!
    @IBOutlet weak var fimsImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        filmLabel.text = films[filmID]
        fimsImage.image = filmImages[filmID]
        nextButton.layer.cornerRadius = 11
        filmImageView.layer.cornerRadius = 20
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func rightButton(_ sender: Any) {
        if filmID + 2 < films.count {
            filmID += 2
            filmLabel.text = films[filmID]
            fimsImage.image = filmImages[filmID]
        }
    }
    
    @IBAction func leftButton(_ sender: Any) {
        if filmID - 1 >= 0 {
            filmID -= 1
            filmLabel.text = films[filmID]
            fimsImage.image = filmImages[filmID]
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SitPickerViewController") as! SitPickerViewController
        if filmID == 1 {
            vc.isCorrectFilm = true
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
