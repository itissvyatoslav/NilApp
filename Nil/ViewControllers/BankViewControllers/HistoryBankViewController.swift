//
//  HistoryBankViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 01.12.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class HistoryBankViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    private let histories = ["Двое пьянчуг. У обоих множественные укусы лица. Купили водки. Распили. Последнюю рюмку не поделили, и один из них залпом её выпил. Товарищ обидевшись на это решил укусить первого в лицо. Укушенный же решил:\"А чего это он безнаказанно меня кусает?\" и кусанул несколько раз в ответ. Стоят в кабинете, обиженные друг на друга, требуют сделать прививки от бешенства: \"Он же бешеный, не видите?\".", "С детства увлекалась фотографией, еще с пленочным ФЭДом, потом с цифровым фотоаппаратом. Когда муж начал слепнуть, я стала отчаянно фотографировать всё подряд, чтобы успеть ему показать: прохожих, птиц, цветы, архитектуру, облака. Если я оказывалась где-то без него, фотографировала и потом показывала все, что могло его заинтересовать. Сейчас я фотограф в интернет-магазине, иногда подрабатываю на мероприятиях или для мастеров делаю презентации, получаю за это деньги. А муж ослеп и больше не видит моих фотографий. Теперь не знаю, зачем мне это всё.", "В подростковом возрасте у меня были длинные красивые волосы. Двоюродная сестра постоянно говорила, как будет хорошо мне подстричься под каре. Она старше и была большим авторитетом для меня. А мама постоянно отговаривала от стрижки, аргументируя тем, что волос тонкий, форму держать хорошо не будет, и длинные волосы идут мне гораздо больше. Подстригалась, не понравилось вообще; зато начала понимать женскую зависть и ценить мамины советы. Волосы отросли, а осадочек остался.", "Сейчас такой период в жизни, наполненный обыденными домашними делами, сижу в декрете с детьми маленькими. Но каждое утро я включаю на экран телевизора веб-камеру из кафе на Ибице, где идёт круглосуточная трансляция моря и играет офигенная музыка. И провожу вместе с ней целый день. Настроение прекрасное, встречаю рассветы и закаты на море, не выезжая из Йошкар-Олы.", "Из окна моей квартиры открывается прекрасный вид на штрафстоянку, на которой помимо штрафников ещё и машины (или части машин) после дтп. Очень мотивирует соблюдать ПДД.", "Этой зимой я повесила кормушку для синичек на окно. Первое время они боялись прилетать, но теперь освоились и регулярно трапезничают на подоконнике. А мои коты сидят с противоположной стороны стекла, бьются о него лбами и облизываются.", "Года три работала в дорогом магазине одежды для женщин размера +. Цены у нас начинались от 10 тыс рублей до 400 тыс рублей за вещь. Постоянные покупатели: чиновницы, прокуратура, налоговая, администрация города и тд. Каждый сезон (весна-лето/осень-зима) постоянные покупательницы обновляли себе гардероб начиная от блузок, футболок, заканчивая верхней одеждой. Средний чек около 500 тыс. рублей. 70% расплачивались только наличными из белых конвертов. Конечно, все честно заработано)))", "Boeing 757-200 - без бизнеса\nBoeing 777-300ER - с бизнесом\nATR 72-500 - без бизнеса\nАн-2 - без бизнеса"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        nextButton.layer.cornerRadius = 11
        historyTextView.text = histories[0]
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var historyCounter = 0
    
    @IBAction func nextTapped(_ sender: Any) {
        var isReadyToClose = false
        if historyCounter + 1 < histories.count {
            historyCounter += 1
            historyTextView.text = histories[historyCounter]
            if historyCounter == histories.count - 1 {
                nextButton.setTitle("Готово", for: .normal)
            }
        } else {
            isReadyToClose = true
        }
        if isReadyToClose {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
