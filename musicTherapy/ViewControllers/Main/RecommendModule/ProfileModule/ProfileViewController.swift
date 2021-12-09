//
//  MTProfileViewController.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import Charts

class ProfileViewController : UIViewController {
    
    let physicalParamterProvider = AudioSession()
    
    let db = Firestore.firestore()
    
    var profile: [Profile] = []
    var profile2: [Profile] = []
    
    var stringArray: [String] = []
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    
    private let stateContainer = UIView()
    
    private let currentStateLabel = UILabel()
    
    private let preasureStateLabel = UILabel()
    
    private let lineChartContainer = UIView()
    
    private lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    
    let yValues : [ChartDataEntry] = [
        
        ChartDataEntry(x: 1.0, y: -4, data: "123"),
        ChartDataEntry(x: 2.0, y: -4, data: "123"),
        ChartDataEntry(x: 3.0, y: -1, data: "123"),
        ChartDataEntry(x: 4.0, y: 3, data: "123"),
        ChartDataEntry(x: 5.0, y: -1, data: "123"),
        ChartDataEntry(x: 6.0, y: 2, data: "123"),
        ChartDataEntry(x: 7.0, y: 6, data: "123")
    ]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.stateContainer)
        self.mainView.addSubview(self.lineChartContainer)
        
        self.stateContainer.addSubview(self.currentStateLabel)
        self.stateContainer.addSubview(self.preasureStateLabel)
        
        self.lineChartContainer.addSubview(self.lineChartView)
        
        self.lineChartView.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let profileBarButtonItem = UIBarButtonItem(title: "Log off", style: .done, target: self, action: #selector(onLogout))
            self.navigationItem.rightBarButtonItem  = profileBarButtonItem

        self.view.layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
        setupSubview()
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupStateContainer()
        self.setupLineChartContainer()
        if Auth.auth().currentUser?.email == "kherashivansh@gmail.com" {
            self.setupLineChartView()
        }
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupStateContainer() {
        self.stateContainer.backgroundColor = .white
        self.stateContainer.layer.cornerRadius = 10
        self.stateContainer.layer.shadowRadius = 5
        self.stateContainer.layer.shadowOpacity = 0.3
        
        self.currentStateLabel.textColor = .black
        self.currentStateLabel.text = "Current state"
        self.currentStateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        readData()
    
        self.preasureStateLabel.numberOfLines = 0
        self.preasureStateLabel.textColor = .black
        
    }
    
    private func setupLineChartContainer() {
        self.lineChartContainer.backgroundColor = .white
        self.lineChartContainer.layer.cornerRadius = 10
        self.lineChartContainer.layer.shadowRadius = 5
        self.lineChartContainer.layer.shadowOpacity = 0.3
    }
    
    private func setupLineChartView() {
        self.setData()
        self.lineChartView.backgroundColor = .black
        self.lineChartView.rightAxis.enabled = false
        self.lineChartView.animate(xAxisDuration: 1.5)
        
    }
    
    func readData() {
       
        db.collection(Fstore.collectionName).order(by: Fstore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.profile = []
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
//                        let profileLowerPressure = data[Fstore.lowerPressure] as? Int
//                        let profileUpperPressure = data[Fstore.upperPressure] as? Int
                        let profilePulse = data[Fstore.pulse] as? Int
                        let profileSleep = data[Fstore.sleep] as? Int
                        let profileSender = data[Fstore.senderField] as? String
                        let profileData = Profile(pulse: profilePulse ?? 0, senderField: profileSender ?? "nil",sleep: profileSleep ?? 0)
                        self.profile.append(profileData)
                        if Auth.auth().currentUser?.email == "kherashivansh@gmail.com" {
                        self.stringArray = ["Pulse - \((self.profile.last?.pulse)!)", "Mood - Calm", "Sleep - \((self.profile.last?.sleep)!)"]
                        } else {
                            self.stringArray = ["Pulse - 90", "Mood - Irritable", "Sleep - 3"]
                        }
                        print("String \(self.stringArray[0])")
                        self.preasureStateLabel.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: self.stringArray, font: UIFont.systemFont(ofSize: 13))
                            }
                        }
                    }
                }
        
            }
    
    
    private func setData() {
        
        let set1 = LineChartDataSet(entries: yValues, label: "well-being")
        
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.setColor(.white)
        set1.mode = .cubicBezier
        let data = LineChartData(dataSet: set1)
        self.lineChartView.data = data
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.stateContainer.snp.makeConstraints {
            $0.top.equalTo(self.mainView).offset(topBarHeight)
            $0.left.equalTo(self.mainView).offset(30)
            $0.right.equalTo(self.mainView).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.centerY).offset(-10)
        }
        
        self.currentStateLabel.snp.makeConstraints {
            $0.top.equalTo(self.stateContainer).offset(10)
            $0.centerX.equalTo(self.stateContainer)
        }
        
        self.preasureStateLabel.snp.makeConstraints {
            $0.left.equalTo(self.stateContainer).offset(10)
            $0.right.equalTo(self.stateContainer).offset(-10)
            $0.centerY.equalTo(self.stateContainer)
        }
        
        self.lineChartContainer.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.centerY)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
        }
        
        self.lineChartView.snp.makeConstraints {
            $0.left.equalTo(self.lineChartContainer.snp.left).offset(10)
            $0.right.equalTo(self.lineChartContainer.snp.right).offset(-10)
            $0.top.equalTo(self.lineChartContainer.snp.top).offset(10)
            $0.bottom.equalTo(self.lineChartContainer.snp.bottom).offset(-10)
        }
        
    }
    
    @objc func onLogout() {
        
        print("logout")
        
        do { try Auth.auth().signOut()
            LoginRouting.presentLoginViewController(fromVC: self)
        }
        
        catch { print("already logged out") }
    }
    
}

extension ProfileViewController : ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}

class NSAttributedStringHelper {
    static func createBulletedList(fromStringArray strings: [String], font: UIFont? = nil) -> NSAttributedString {

        let fullAttributedString = NSMutableAttributedString()
        let attributesDictionary: [NSAttributedString.Key: Any]

        if font != nil {
            attributesDictionary = [NSAttributedString.Key.font: font!]
        } else {
            attributesDictionary = [NSAttributedString.Key: Any]()
        }

        for index in 0..<strings.count {
            let bulletPoint: String = "\u{2022}"
            var formattedString: String = "\(bulletPoint) \(strings[index])"

            if index < strings.count - 1 {
                formattedString = "\(formattedString)\n"
            }

            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: attributesDictionary)
            let paragraphStyle = NSAttributedStringHelper.createParagraphAttribute()
   attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
        fullAttributedString.append(attributedString)
       }

        return fullAttributedString
    }

    private static func createParagraphAttribute() -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 11
        return paragraphStyle
    }
}
