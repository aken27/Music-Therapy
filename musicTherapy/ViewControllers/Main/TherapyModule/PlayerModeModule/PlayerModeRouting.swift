//
//  PlayerModeRouting.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

class PlayerModeRouting {
    
    static func presentPlayerModeViewController(fromVC : UIViewController, track : Track?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerModeViewController") as! PlayerModeViewController
        vc.track = track
        fromVC.present(vc, animated: true, completion: nil)
    }

}
