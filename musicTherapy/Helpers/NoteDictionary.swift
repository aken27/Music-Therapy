//
//  NoteDictionary.swift
//  musicTherapy
//
//  Created by kkerors on 01.02.2021.
//

import Foundation
import AudioKit
    
    // 0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120   -> C
    // 1, 13, 25, 37, 49, 61, 73, 85, 97, 109, 12    -> C#
    // 2, 14, 26, 38, 50, 62, 74, 86, 98, 110, 122   -> D
    // 3, 15, 27, 39, 51, 63, 75, 87, 99, 111, 123   -> D#
    // 4, 16, 28, 40, 52, 64, 76, 88, 100, 112, 124  -> E
    // 5, 17, 29, 41, 53, 65, 77, 89, 101, 113, 125  -> F
    // 6, 18, 30, 42, 54, 66, 78, 90, 102, 114, 126  -> F#
    // 7, 19, 31, 43, 55, 67, 79, 91, 103, 115, 127  -> G
    // 8, 20, 32, 44, 56, 68, 80, 92, 104, 116,      -> G#
    // 9, 21, 33, 45, 57, 69, 81, 93, 105, 117       -> A
    // 10, 22, 34, 46, 58, 70, 82, 94, 106, 118      -> A#
    // 11, 23, 35, 47, 59, 71, 83, 95, 107, 119      -> B

public func recursiveNote(_ intNode: Int) -> MIDIKeyString {
    if intNode == 0{
        return .noteC
    }
    if intNode == 1{
        return .noteCSharp
    }
    if intNode == 2{
        return .noteD
    }
    if intNode == 3{
        return .noteDSharp
    }
    if intNode == 4{
        return .noteE
    }
    if intNode == 5{
        return .noteF
    }
    if intNode == 6{
        return .noteFSharp
    }
    if intNode == 7{
        return .noteG
    }
    if intNode == 8{
        return .noteGSharp
    }
    if intNode == 9{
        return .noteA
    }
    if intNode == 10{
        return .noteASharp
    }
    if intNode == 11{
        return .noteB
    }
    if intNode > 11 {
        return recursiveNote(intNode-12)
    }
    return .default
}

public enum MIDIKeyString: String {
    case noteC = "C"
    case noteCSharp = "C#"
    case noteD = "D"
    case noteDSharp = "D#"
    case noteE = "E"
    case noteF = "F"
    case noteFSharp = "F#"
    case noteG = "G"
    case noteGSharp = "G#"
    case noteA = "A"
    case noteASharp = "A#"
    case noteB = "B"
    case `default` = "ERROR"
}
