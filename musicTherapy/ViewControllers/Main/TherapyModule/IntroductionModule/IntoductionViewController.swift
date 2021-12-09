//
//  MTIntoductionViewController.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit
import SnapKit
import Firebase

class IntoductionViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let startButton = SampleButton()
    private let introductionStepsView = IntroductionStepsView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Music Therapy")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.startButton)
        self.mainView.addSubview(self.introductionStepsView)
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
        if Auth.auth().currentUser == nil {
            LoginRouting.presentLoginViewController(fromVC: self)
        }
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupStartButton()
    }
    
    private func setupMainView(){
        self.view.backgroundColor = .white
        self.mainView.backgroundColor = .white
    }
    
    private func setupStartButton() {
        self.startButton.mainLabel.text = "Begin"
        self.startButton.mainLabel.textColor = .white
        self.startButton.backgroundColor = .black
        self.startButton.layer.cornerRadius = 10
        self.startButton.layer.masksToBounds = true
        self.startButton.addTarget(self, action: #selector(onStartClick), for: .touchDown)
    }
    
    @objc func onStartClick(sender: UIButton) {
        PhysicalParametersRouting.presentPhysicalParametersViewController(fromVC: self)
        // Add a second document with a generated ID.
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.startButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.height.equalTo(56)
        }
        
        self.introductionStepsView.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(self.topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.startButton.snp.top).offset(-30)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

extension UIViewController {

    func setupLargeTitle(title : String?) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = title
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
    }
    
}

extension UIViewController {
    
    var topBarHeight: CGFloat {
        
        if UIDevice.modelName == "iPhone SE" {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 30) + 30
        } else {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 30) + 60
        }

    }
    
    var bottomHeight: CGFloat {
        return (self.tabBarController?.tabBar.frame.size.height ?? 30) + 30
    }
    
}

