//
//  ColorTestRouting.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

class ColorTestRouting {
    
    static func presentColorTestViewController(fromVC: UIViewController, audioSession: AudioSession?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColorTestViewController") as! ColorTestViewController
        vc.modalPresentationStyle = .fullScreen
        vc.audioSession = audioSession!
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
