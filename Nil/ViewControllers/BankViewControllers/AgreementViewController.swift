//
//  AgreementViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 05.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

protocol AgreementDelegate {
    func agreeAction()
}

class AgreementViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var slowScrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    var delegate: AgreementDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agreeButton.layer.cornerRadius = 11
        closeButton.layer.cornerRadius = 11
        textLabel.text = """
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        Огромный, нудный текст про соглашение.
        Соглашаясь вы подписываетесь кровью
        и продаете свою душу. Вы никогда не
        сможете избавиться от нашего банка и
        погасить все кредиты, открытые у нас.
        
        """
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.agreeAction()
    }
    
}
