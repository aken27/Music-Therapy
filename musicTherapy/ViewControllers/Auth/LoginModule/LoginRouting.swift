//
//  LoginViewControllerRouting.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit

class LoginRouting {
    
    static func presentLoginViewController(fromVC: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        fromVC.present(vc, animated: true, completion: nil)
    }
    
}
