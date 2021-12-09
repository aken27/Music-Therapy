//
//  MTRegisterRouting.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit

class RegisterRouting {
    
    static func presentRegisterViewController(fromVC: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        fromVC.present(vc, animated: true, completion: nil)
    }
    
}
