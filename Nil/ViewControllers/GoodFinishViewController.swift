//
//  GoodFinishViewController.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 07.11.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class GoodFinishViewController: UIViewController {
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        finishButton.layer.cornerRadius = 11
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    @IBAction func blackButtonTapped(_ sender: Any) {
    }
    
    @IBAction func smallButtonTapped(_ sender: Any) {
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
