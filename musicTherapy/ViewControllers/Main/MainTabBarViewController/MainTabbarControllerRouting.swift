//
//  MainTabbarControllerRouting.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit

class MainTabBarRouting {
    
    static func presentMainTabBarViewController(fromVC: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        vc.modalPresentationStyle = .fullScreen
        fromVC.present(vc, animated: true, completion: nil)
    }
    
}
