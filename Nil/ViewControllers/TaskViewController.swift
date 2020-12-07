//
//  TaskViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 07.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    var idTask = -1
    
    let names = ["Билет", "Перевод", "Врач", "Обучение"]
    let history = ["Ваш сын захотел побывать на финале испанской лиги по футболу. Матч начинается уже завтра в 20:00 по местному времени", "Ваша жена каталась с соседкой за покупками, а возил их муж соседки на своей Ладе Приоре.", "Уже завтра в 14:00 экзамен в автошколе, а у вас еще нет справки от врача-психиатра.", "Сегодня выдался тяжелый рабочий день и единственное, что Вам может помочь - просмтор хорошоего фильма в кинотеатре."]
    let tasks = ["Задача: Купить билеты с багажом в бизнес классе на прилет в 19:00 в Барселону", "Задача: Перевести Владимиру Иванову 1300р за бензин", "Задача: Записаться в ГП №11 к психиатру", "Забронируй место в кинотеатре для себя на фильм ужасов вечером"]
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var nameTaskLabel: UILabel!
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var historyTextLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setView()
    }
    
    private func setView(){
        phoneLabel.isHidden = true
        nextButton.layer.cornerRadius = 11
        nameTaskLabel.text = names[idTask]
        taskTextLabel.text = tasks[idTask]
        historyTextLabel.text = history[idTask]
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    @IBAction func nextTapped(_ sender: Any) {
        switch idTask {
        case 0:
            let storyboard = UIStoryboard(name: "Tickets", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GeoViewController") as! GeoViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 1:
            let storyboard = UIStoryboard(name: "Bank", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainBankViewController") as! MainBankViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 2:
            let storyboard = UIStoryboard(name: "Hospital", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainHospitalViewController") as! MainHospitalViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 3:
            let storyboard = UIStoryboard(name: "Instruction", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [self] _ in
            
            if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) && idTask == 1 {
                taskTextLabel.text = " Задача: Перевести Владимиру Иванову (+7 (213) 543-34-32) 98р за бензин"
            } else {
                taskTextLabel.text = tasks[idTask]
            }

        }
    }
}
