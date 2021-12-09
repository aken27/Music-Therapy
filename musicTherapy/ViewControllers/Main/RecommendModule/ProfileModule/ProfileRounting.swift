//
//  ProfileRounting.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit

class ProfileRouting {
    
    static func presentProfileViewController(fromVC: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.modalPresentationStyle = .fullScreen
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
