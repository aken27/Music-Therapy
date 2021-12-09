//
//  AudioSession.swift
//  musicTherapy
//
//  Created by kkerors on 01.03.2021.
//

import Foundation
import UIKit

struct AudioSession {
    var physicalParams = PhysicalParameters()
    var emotionalParams = EmotionalParameters(moodType: .positive)
    var type = TrackType.black
}

struct PhysicalParameters {
    var pulse: Int?
    var sleep: Int?
//    var pulse: Int?
}

struct EmotionalParameters {
    var moodType: MoodType
}

enum MoodType: String {
    case positive = "Positive"
    case sad = "Sad"
    case bored = "Bored"
    case inspired = "Inspiring"
    case irritable = "Irritable"
    case calm = "Calm"
    case funny = "Merry"
}

enum MoodSong {
    
    case lyric
    case happy
    case contemplative
}

enum SpeedType {
    case slow
    case normal
    case fast
}
