//
//  Track.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

struct Track {
    
    var id : String?
    var author : String?
    var name : String?
    var time : String?
    var type : TrackType?
    var image : UIImage?
    var path : String?
    var state : PlayingState?
    
}

enum TrackType {
    
    case black
    case brown
    case purple
    case grey
    case blue
    case red
    case green
    case yellow
    
}
