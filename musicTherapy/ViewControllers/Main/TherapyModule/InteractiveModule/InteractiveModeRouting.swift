//
//  ModeRouting.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit

class InteractiveModeRouting {
    
    static func presentInteractiveModeViewController(fromVC: UIViewController, track : Track?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InteractiveModeViewController") as! InteractiveModeViewController
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = true
        vc.track = track
//        fromVC.navigationController?.pushViewController(vc, animated: true)
        fromVC.present(vc, animated: true, completion: nil)
    }
    
}
