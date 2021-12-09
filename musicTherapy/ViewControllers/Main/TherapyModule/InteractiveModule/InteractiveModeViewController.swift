//
//  ModeViewController.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import UIKit
import AudioKit
import AudioKitUI
import SnapKit

class InteractiveModeViewController: UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let keyboardView = AKKeyboardView()
    private let containerForNote = UIView()
    private let noteLabel = UILabel()
    private let swiftyOscillatorBank = AKOscillatorBank()
    private let containerForOscillator = UIView()
    
    private var delay : AKDelay? = nil
    private var reverb : AKReverb2? = nil
    
    var track : Track?
    
    private let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        AKManager.midi.createVirtualInputPort()
        AKManager.midi.openInput()
        AKManager.midi.addListener(self)
        
        delay = AKDelay(swiftyOscillatorBank)
        delay?.time = 0.5 // seconds
        delay?.feedback = 0.2 // Normalized Value 0 - 1
        delay?.dryWetMix = 0.2 // Normalized Value 0 - 1
        
        reverb = AKReverb2(delay)
        reverb?.dryWetMix = 0.5
        
        AKManager.output = reverb
        
        self.setupAudioSession()
        self.setupMainView()
        self.setupKeyboardView()
        self.setupContainerForNote()
        self.setupNoteLabel()
        self.setupOscillatorBank()
        self.setupContainerForOscillator()
        self.setupOscillator()
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.keyboardView)
        self.mainView.addSubview(self.containerForNote)
        self.mainView.addSubview(self.containerForOscillator)
        self.containerForNote.addSubview(self.noteLabel)
        
        // MARK: SETUP AUDIO PLOT
        
        let plot = AKNodeOutputPlot(reverb)
        plot.plotType = .buffer
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.color = AKColor.black
        self.mainView.addSubview(plot)
        
        self.setupSubview()
        
        plot.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.centerY).offset(-60)
        }
        
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupAudioSession() {
        let outputVolume = AVAudioSession.sharedInstance().outputVolume
        debugPrint("Output volume: \(outputVolume)")
    }
    
    private func setupMainView() {
        self.mainView.backgroundColor = .white
    }
    
    private func setupKeyboardView() {
        self.keyboardView.delegate = self
        self.keyboardView.polyphonicMode = true
        self.keyboardView.octaveCount = 1
        self.keyboardView.firstOctave = 3
    }
    
    private func setupContainerForNote() {
        self.containerForNote.isUserInteractionEnabled = true
        let interaction = UIContextMenuInteraction(delegate: self)
        self.containerForNote.addInteraction(interaction)
        self.containerForNote.layer.cornerRadius = 7
        self.containerForNote.layer.borderWidth = 2
        self.containerForNote.layer.borderColor = UIColor.white.cgColor
        self.containerForNote.layer.masksToBounds = true
        self.containerForNote.backgroundColor = .black
    }
    
    private func setupNoteLabel() {
        self.noteLabel.textColor = .white
        self.noteLabel.textAlignment = .center
        self.noteLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.noteLabel.text = "..."
    }
    
    private func setupOscillatorBank() {
//        AKManager.output = swiftyOscillatorBank
        try? AKManager.start()
    }
    
    private func updateNoteLabel(text: String) {
        self.noteLabel.text = text
    }
    
    private func setupContainerForOscillator() {
        self.containerForOscillator.backgroundColor = .black
    }
    
    private func setupOscillator() {
//        let oscillator = AKOutputWaveformPlot.createView(width: 200, height: 250)
//        self.containerForOscillator.addSubview(oscillator)
//        oscillator.backgroundColor = .yellow
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        
        self.mainView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.keyboardView.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(20)
            $0.right.equalTo(self.mainView.snp.right).offset(-20)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-20)
            $0.top.equalTo(self.screenSize.height/2)
        }
        
        self.containerForNote.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(20)
            $0.bottom.equalTo(self.keyboardView.snp.top).offset(-20)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        self.noteLabel.snp.makeConstraints {
            $0.edges.equalTo(self.containerForNote.snp.edges)
        }
                
//        self.containerForOscillator.snp.makeConstraints {
//            $0.width.equalTo(200)
//            $0.height.equalTo(50)
//            $0.top.equalTo(self.mainView.snp.top)
//            $0.centerX.equalTo(self.mainView.snp.centerX)
//        }
        
     }
    
    func makeContextMenu() -> UIMenu {
        let one = UIAction(title: "🎹", image: nil) { action in
            self.keyboardView.octaveCount = 1
            self.keyboardView.reloadInputViews()
            self.keyboardView.setNeedsDisplay()
            }
        let two = UIAction(title: "🎹🎹", image: nil) { action in
            self.keyboardView.octaveCount = 2
            self.keyboardView.reloadInputViews()
                self.keyboardView.setNeedsDisplay()
            }
        let three = UIAction(title: "🎹🎹🎹", image: nil) { action in
            self.keyboardView.octaveCount = 3
            self.keyboardView.reloadInputViews()
            self.keyboardView.setNeedsDisplay()
            }
        let four = UIAction(title: "🎹🎹🎹🎹", image: nil) { action in
            self.keyboardView.octaveCount = 4
            self.keyboardView.reloadInputViews()
            self.keyboardView.setNeedsDisplay()
            }

        
        return UIMenu(title: "Октавы", children: [one, two, three, four])
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            print("Shake Gesture Detected")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        do {
            AKManager.disconnectAllInputs()
            try AKManager.stop()
        } catch {
            fatalError("AudioKit crash")
        }
    }

}

extension InteractiveModeViewController: AKKeyboardDelegate {
    
    func noteOn(note: MIDINoteNumber) {
        
        debugPrint(recursiveNote(Int(note.magnitude)).rawValue)
        
        let textToUpdateNoteLabel = recursiveNote(Int(note.magnitude)).rawValue
        self.updateNoteLabel(text: textToUpdateNoteLabel)
        self.swiftyOscillatorBank.play(noteNumber: note, velocity: 80)
    }
    
    func noteOff(note: MIDINoteNumber) {
        self.swiftyOscillatorBank.stop(noteNumber: note)
    }
    
}

extension InteractiveModeViewController : UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
        return self.makeContextMenu()
        })
    }
}

extension InteractiveModeViewController : AKMIDIListener {
    
    func receivedMIDINoteOn(noteNumber: MIDINoteNumber,
                            velocity: MIDIVelocity,
                            channel: MIDIChannel,
                            portID: MIDIUniqueID? = nil,
                            offset: MIDITimeStamp = 0) {
        print("note \(noteNumber) on")
            DispatchQueue.main.async {
                self.noteOn(note: noteNumber)
            }
        }
    
    func receivedMIDINoteOff(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("note \(noteNumber) off")
            DispatchQueue.main.async {
                self.noteOff(note: noteNumber)
            }
        }
}

