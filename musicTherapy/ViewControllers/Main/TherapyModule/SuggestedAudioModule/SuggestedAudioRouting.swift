//
//  SuggestedAudioRouting.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit

class SuggestedAudioRouting {
    
    static func presentSuggestedAudioViewController(fromVC: UIViewController, trackType: TrackType?, trackArray: [Track?]) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuggestedAudioViewController") as! SuggestedAudioViewController
        vc.trackType = trackType
        vc.tracks = trackArray
        vc.modalPresentationStyle = .fullScreen
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
