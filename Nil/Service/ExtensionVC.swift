//
//  ExtensionVC.swift
//  Nil
//
//  Created by Svyatoslav Vladimirovich on 30.10.2020.
//  Copyright © 2020 Svyatoslav Vladimirovich. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    /* use like:
 
    for controller in self.navigationController!.viewControllers as
        Array {
            if controller.isKind(of:
                yourPopControllerName.self) {
                
                self.navigationController?.isNavigationBarHidden = false
                _ =
                    self.navigationController!.popToViewController(controller,
                                                                   animated: false)
                break
            }
    }
     */
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
}

//check
