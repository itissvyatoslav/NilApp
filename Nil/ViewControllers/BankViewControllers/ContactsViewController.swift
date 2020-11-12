//
//  ContactsViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 04.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    var cardSumm = 0
    var cardNumber = ""
    
    var toPhone = false
    
    struct Contact {
        var name: String
        var telephone: String
    }
    
    let contacts = [Contact(name: "Абдула", telephone: "+7 (123) 486-78-90"), Contact(name: "Артем", telephone: "+7 (153) 456-78-90"), Contact(name: "Артем", telephone: "+7 (123) 456-93-90"), Contact(name: "Брат", telephone: "+7 (345) 456-78-90"), Contact(name: "Боря", telephone: "+7 (123) 324-54-32"), Contact(name: "Вован", telephone: "+7 (123) 432-23-43"), Contact(name: "Вован", telephone: "+7 (213) 543-34-32"), Contact(name: "Володя", telephone: "+7 (321) 343-23-90"), Contact(name: "Вовчик", telephone: "+7 (111) 432-54-32"), Contact(name: "Виктория Сергеевна", telephone: "+7 (213) 432-12-54"), Contact(name: "Лера, жена", telephone: "+7 (777) 321-43-54"), Contact(name: "Гараж аренда", telephone: "+7 (321) 324-55-66"), Contact(name: "Денег должен", telephone: "+7 (321) 111-32-54"), Contact(name: "Деда", telephone: "+7 (654) 25-63-31"), Contact(name: "Димон", telephone: "+7 (543) 554-66-31"), Contact(name: "Евгений Владимирович", telephone: "+7 (543) 555-12-65"), Contact(name: "Зинаида Михайловна Бухгалтер", telephone: "+7 (324) 543-65-11"), Contact(name: "Мама", telephone: "+7 (854) 321-55-11"), Contact(name: "Катя ❤️", telephone: "+7 (314) 432-21-43"), Contact(name: "Папа", telephone: "+7 (123) 433-55-11"), Contact(name: "Ростик", telephone: "+7 (321) 113-44-12"), Contact(name: "НЕ БРАТЬ!!!", telephone: "+7 (555) 443-23-12"), Contact(name: "Ульяна", telephone: "+7 (554) 334-91-90"), Contact(name: "Фируза", telephone: "+7 (909) 312-44-55"), Contact(name: "хз", telephone: "+7 (543) 123-66-35"), Contact(name: "Я", telephone: "+7 (777) 777-77-77"), Contact(name: "Я МТС", telephone: "+7 (913) 777-77-77"), Contact(name: "Ярослав", telephone: "+7 (543) 444-33-90"), Contact(name: "Ярослав", telephone: "+7 (543) 444-33-90"), Contact(name: "Ярослав брат Леры", telephone: "+7 (555) 432-65-17"), Contact(name: "DPD курьер", telephone: "+7 (126) 432-74-74"), Contact(name: "IKEA доставка", telephone: "+7 (565) 456-24-24")]
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var contactsTable: UITableView!
    @IBOutlet weak var tepelphoneTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setTable()
        tepelphoneTF.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func setTable(){
        self.contactsTable.register(UINib(nibName: "ContactTableCell", bundle: nil), forCellReuseIdentifier: "ContactTableCell")
        contactsTable.delegate = self
        contactsTable.dataSource = self
        contactsTable.backgroundColor = UIColor.black
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewControllers(viewsToPop: 3)
    }
    
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableCell") as! ContactTableCell
        cell.backgroundColor = UIColor.black
        cell.nameLabel.text = contacts[indexPath.row].name
        cell.phoneLabel.text = contacts[indexPath.row].telephone
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        vc.toPhone = self.toPhone
        vc.cardSumm = self.cardSumm
        vc.cardNumber = self.cardNumber
        vc.contactName = contacts[indexPath.row].name
        vc.contactPhone = contacts[indexPath.row].telephone
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
