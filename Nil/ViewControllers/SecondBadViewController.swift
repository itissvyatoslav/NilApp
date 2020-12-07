//
//  SecondBadViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 25.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class SecondBadViewController: UIViewController {
    
    @IBOutlet weak var restartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        restartButton.layer.cornerRadius = 11
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func restartAction(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as
            Array {
                if controller.isKind(of:
                    MainMenuViewController.self) {
                    _ =
                        self.navigationController!.popToViewController(controller,
                                                                       animated: false)
                    break
                }
        }
    }
    
}
