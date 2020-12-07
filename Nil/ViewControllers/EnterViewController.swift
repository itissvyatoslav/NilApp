//
//  EnterViewController.swift
//  Nil
//
//  Created by Святослав Шевченко on 01.12.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setGif()
    }
    
    private func setGif() {
        gifImageView.image = UIImage.gifImageWithName("preloader")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5) {
                self.gifImageView.alpha = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
            vc.modalTransitionStyle = .crossDissolve
            vc.isFirstEnter = true
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override var prefersStatusBarHidden: Bool {return true}
}
