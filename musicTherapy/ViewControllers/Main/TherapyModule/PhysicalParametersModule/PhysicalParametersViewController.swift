//
//  PhysicalParametersViewController.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit
import SnapKit
import Firebase

class PhysicalParametersViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let pulseTextField = DefaultTextField()
    private let sleepTextField = DefaultTextField()
//    private let pulseTextField = DefaultTextField()

//    private let moodSlider = UISlider()
    private let nextButton = SampleButton()
    
    private var pulse : Int?
    private var sleep : Int?
//    private var pulse : Int?
    private var mood : MoodType?
    
    private var audioSession = AudioSession()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Physical Parameters")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.pulseTextField)
        self.mainView.addSubview(self.sleepTextField)
//        self.mainView.addSubview(self.pulseTextField)
//        self.mainView.addSubview(self.sleepTrackField)
        self.mainView.addSubview(self.nextButton)
//        self.mainView.addSubview(self.moodSlider)
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupPulseTextField()
        self.setupSleepTextField()
        self.setupPulseTextField()
//        self.setupSleepTrackTextField()
//        self.setupMoodSlider()
        self.setupNextButton()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupPulseTextField(){
        self.pulseTextField.setPlaceholder("Pulse")
        self.pulseTextField.keyboardType = .numberPad
    }
    
    private func setupSleepTextField(){
        self.sleepTextField.setPlaceholder("Sleep Hours")
        self.sleepTextField.keyboardType = .numberPad
    }
    
//    private func setupPulseTextField(){
//        self.pulseTextField.setPlaceholder("Pulse")
//        self.pulseTextField.keyboardType = .numberPad
//    }
    
    private func setupNextButton() {
        self.nextButton.mainLabel.text = "Next"
        self.nextButton.mainLabel.textColor = .white
        self.nextButton.backgroundColor = .black
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.layer.masksToBounds = true
        self.nextButton.addTarget(self, action: #selector(onNextClick), for: .touchDown)
    }
    
    private func checkData() {
        
        if self.pulse != nil && self.sleep != nil  {
            self.saveParams()
            EmotionalParametersRouting.presentEmotionalParametersViewController(fromVC: self, audioSession: self.audioSession)
        }
        
    }
    
    private func saveParams() {
        
            self.audioSession.physicalParams.pulse = self.pulse
            self.audioSession.physicalParams.sleep = self.sleep
//            self.audioSession.physicalParams.pulse = self.pulse

            if let profileSender = Auth.auth().currentUser?.email {
                db.collection(Fstore.collectionName).addDocument(data: [
//                    Fstore.upperPressure: self.audioSession.physicalParams.upperPreasure!,
//                    Fstore.lowerPressure: self.audioSession.physicalParams.lowerPreasure!,
                    Fstore.pulse: self.audioSession.physicalParams.pulse!,
                    Fstore.sleep: self.audioSession.physicalParams.sleep!,
                    Fstore.senderField: profileSender,
                    Fstore.dateField: Date().timeIntervalSince1970
                ]) { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else {
                        print("Successfully saved data.")
                    }
                }
            }
    }

    @objc func onNextClick() {
        self.pulse = Int(self.pulseTextField.text ?? "")
        self.sleep = Int(self.sleepTextField.text ?? "")
//        self.pulse = Int(self.pulseTextField.text ?? "")
        self.checkData()
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.pulseTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.mainView.snp.top).offset(self.topBarHeight)
        }
        self.sleepTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.pulseTextField.snp.bottom).offset(30)
        }
//        self.pulseTextField.snp.makeConstraints {
//            $0.left.equalTo(self.mainView.snp.left).offset(30)
//            $0.right.equalTo(self.mainView.snp.right).offset(-30)
//            $0.top.equalTo(self.lowerPreasureTextField.snp.bottom).offset(30)
//        }
        self.nextButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.height.equalTo(56)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

