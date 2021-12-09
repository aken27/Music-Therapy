//
//  PhysicalParameterRouting.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit

class PhysicalParametersRouting {
    
    static func presentPhysicalParametersViewController(fromVC: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhysicalParametersViewController") as! PhysicalParametersViewController
        vc.modalPresentationStyle = .fullScreen
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
