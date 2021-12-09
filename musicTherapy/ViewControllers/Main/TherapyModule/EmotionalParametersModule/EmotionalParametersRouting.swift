//
//  EmotionalParametersRouting.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit

class EmotionalParametersRouting {
    
    static func presentEmotionalParametersViewController(fromVC: UIViewController, audioSession: AudioSession?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmotionalParametersViewController") as! EmotionalParametersViewController
        vc.modalPresentationStyle = .fullScreen
        vc.audioSession = audioSession!
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
