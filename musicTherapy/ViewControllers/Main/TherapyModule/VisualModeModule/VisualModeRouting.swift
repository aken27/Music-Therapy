//
//  VisualModeRouting.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

class VisualModeRouting {
    
    static func presentVisualModeViewController(fromVC: UIViewController, track : Track?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VisualModeViewController") as! VisualModeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.track = track
        vc.hidesBottomBarWhenPushed = true
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }

}
