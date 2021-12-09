//
//  TherapyNavigationController.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

class TherapyNavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
}
