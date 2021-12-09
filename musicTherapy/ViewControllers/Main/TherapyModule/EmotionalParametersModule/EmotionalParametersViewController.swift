//
//  EmotionalParameters.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit
import SnapKit
import Firebase

class EmotionalParametersViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    
    private let pickerArea = UIView()
    private let moodPicker = UIPickerView()

    private let moodLabel = UILabel()
    private let moodsArray : [String?] = ["Positive", "Sad", "Calm", "Bored", "Inspiring", "Irritable", "Merry"]
    
    private let nextButton = SampleButton()
    
    private var selectedPickerValue : String?
    
    public var audioSession = AudioSession()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.nextButton)
        self.mainView.addSubview(self.pickerArea)
        self.pickerArea.addSubview(self.moodLabel)
        self.pickerArea.addSubview(self.moodPicker)
        
        self.moodPicker.delegate = self
        self.moodPicker.dataSource = self
        
        self.setupLargeTitle(title: "Mood Parameters")
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupAreas()
        self.setupMoodLabel()
        self.setupMoodPicker()
        self.setupNextButton()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupAreas() {
        self.pickerArea.backgroundColor = .white
        self.pickerArea.layer.cornerRadius = 10
        self.pickerArea.layer.shadowRadius = 5
        self.pickerArea.layer.shadowOpacity = 0.3
    }
    
    private func setupMoodLabel() {
        self.moodLabel.text = "Mood:"
        self.moodLabel.textColor = .black
        self.moodLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func setupMoodPicker() {
        self.moodPicker.tintColor = .black
    }
    
    private func setupNextButton() {
        self.nextButton.mainLabel.text = "Next"
        self.nextButton.mainLabel.textColor = .white
        self.nextButton.backgroundColor = .black
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.layer.masksToBounds = true
        self.nextButton.addTarget(self, action: #selector(onNextClick), for: .touchDown)
    }

    @objc func onNextClick() {
        
        switch selectedPickerValue {
        case MoodType.bored.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.bored
        case MoodType.calm.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.calm
        case MoodType.funny.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.funny
        case MoodType.inspired.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.inspired
        case MoodType.irritable.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.irritable
        case MoodType.positive.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.positive
        case MoodType.sad.rawValue:
            self.audioSession.emotionalParams.moodType = MoodType.sad
        default:
            self.audioSession.emotionalParams.moodType = MoodType.positive
        }
        
//        if let profileSender = Auth.auth().currentUser?.email {
//            
//            db.collection(Fstore.collectionName_2).addDocument(data: [
//                Fstore.mood: selectedPickerValue!,
//                Fstore.senderField: profileSender,
//                Fstore.dateField: Date().timeIntervalSince1970
//            ]) { (error) in
//                if let e = error {
//                    print("There was an issue saving data to firestore, \(e)")
//                } else {
//                    print("Successfully saved data.")
//                }
//            }
//        }
        
        ColorTestRouting.presentColorTestViewController(fromVC: self, audioSession: self.audioSession)
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.nextButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.height.equalTo(56)
        }
        
        self.pickerArea.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(self.topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.nextButton.snp.top).offset(-30)
        }
        
        self.moodLabel.snp.makeConstraints {
            $0.top.equalTo(self.pickerArea.snp.top).offset(10)
            $0.centerX.equalTo(self.pickerArea.snp.centerX)
        }
        
        self.moodPicker.snp.makeConstraints {
            $0.top.equalTo(self.moodLabel.snp.bottom).offset(10)
            $0.left.equalTo(self.pickerArea.snp.left).offset(10)
            $0.right.equalTo(self.pickerArea.snp.right).offset(-10)
            $0.bottom.equalTo(self.pickerArea.snp.bottom).offset(-10)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension EmotionalParametersViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moodsArray.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        return NSAttributedString(string: moodsArray[row]!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont.systemFont(ofSize: 15)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = moodsArray[row]
            pickerLabel?.textColor = UIColor.black

            return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPickerValue = self.moodsArray[pickerView.selectedRow(inComponent: 0)]
    }
    
}
