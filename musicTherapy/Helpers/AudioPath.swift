//
//  AudioPath.swift
//  musicTherapy
//
//  Created by kkerors on 19.02.2021.
//

import Foundation
import AudioKit

func createAudioPath(name : String?) -> EZAudioFile? {
    let path = Bundle.main.path(forResource: name, ofType: "mp3")!
    let url = URL(fileURLWithPath: path)
    let file = EZAudioFile(url: url)
    return file
}
