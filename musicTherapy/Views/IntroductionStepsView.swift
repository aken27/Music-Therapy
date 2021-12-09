//
//  IntroductionStepsView.swift
//  musicTherapy
//
//  Created by kkerors on 02.03.2021.
//

import Foundation
import UIKit
import SnapKit

class IntroductionStepsView: UIView {
    
    private let mainView = UIView()
    private let lineView: [UIView] = [UIView(), UIView(), UIView()]
    private let stepsView: [UIView] = [UIView(), UIView(), UIView(), UIView()]
    private let stepsNumLabel: [UILabel] = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let stepsNum: [String] = ["1, 2, 3, 4"]
    private let stepsValueLabel: [UILabel] = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let stepsValue: [String] = ["Physical parameters", "Mood parameters", "Color selection", "Suggested audio"]
    
    override init(frame : CGRect){
        super.init(frame: frame)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup(){
        
        self.addSubview(self.mainView)
        
        for i in 0...stepsView.count-1 {
            self.mainView.addSubview(stepsView[i])
            self.stepsView[i].addSubview(self.stepsNumLabel[i])
        }
        
        for i in stepsValueLabel {
            self.mainView.addSubview(i)
        }
        
        for i in lineView {
            self.mainView.addSubview(i)
        }
        
        self.setupViews()
        self.setupConstraints()
        self.showViews()
        
    }
    
    private func setupViews() {
        self.hideViews()
        self.setupMainView()
        self.setupLineView()
        self.setupStepView()
        self.setupNumLabel()
        self.setupValueLabel()
    }
    
    private func hideViews() {
        for i in self.stepsNumLabel {
            i.alpha = 0
        }
        
        for i in stepsValueLabel {
            i.alpha = 0
        }
    }
    
    private func showViews() {
        UIView.animate(withDuration: 0.5) {
            self.stepsNumLabel[0].alpha = 1
            self.stepsValueLabel[0].alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.stepsNumLabel[1].alpha = 1
                self.stepsValueLabel[1].alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.stepsNumLabel[2].alpha = 1
                    self.stepsValueLabel[2].alpha = 1
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.stepsNumLabel[3].alpha = 1
                        self.stepsValueLabel[3].alpha = 1
                    } completion: { _ in
                        return
                    }
                }
            }
        }
    }
    
    private func setupMainView() {
        self.backgroundColor = .white
        self.mainView.backgroundColor = .black
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.shadowRadius = 5
        self.mainView.layer.shadowOpacity = 0.3
    }
    
    private func setupLineView() {
        for i in lineView {
            i.backgroundColor = .white
        }
    }
    
    private func setupStepView() {
        for i in stepsView {
            i.backgroundColor = .white
            i.layer.cornerRadius = 10
            i.layer.masksToBounds = true
            i.layer.shadowRadius = 5
            i.layer.shadowOpacity = 0.3
        }
    }
    
    private func setupNumLabel() {
        for i in 0...stepsNumLabel.count-1 {
            self.stepsNumLabel[i].textColor = .black
            self.stepsNumLabel[i].font = .boldSystemFont(ofSize: 15)
            self.stepsNumLabel[i].text = "\(i+1)"
        }
    }
    
    private func setupValueLabel() {
        for i in 0...stepsValueLabel.count-1 {
            self.stepsValueLabel[i].textColor = .white
            self.stepsValueLabel[i].font = .boldSystemFont(ofSize: 15)
            self.stepsValueLabel[i].text = stepsValue[i]
        }
    }
    
    private func setupConstraints(){
        
        self.mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        self.lineView[1].snp.makeConstraints {
            $0.centerY.equalTo(self.mainView.snp.centerY)
            $0.width.equalTo(2)
            $0.height.equalTo(15)
            $0.centerX.equalTo(self.stepsView[1].snp.centerX)
        }
        
        self.stepsView[1].snp.makeConstraints {
            $0.bottom.equalTo(self.lineView[1].snp.top).offset(-5)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        
        self.stepsNumLabel[1].snp.makeConstraints {
            $0.centerX.equalTo(self.stepsView[1].snp.centerX)
            $0.centerY.equalTo(self.stepsView[1].snp.centerY)
        }
        
        self.stepsValueLabel[1].snp.makeConstraints {
            $0.centerY.equalTo(self.stepsView[1].snp.centerY)
            $0.left.equalTo(self.stepsView[1].snp.right).offset(10)
        }
        
        self.lineView[0].snp.makeConstraints {
            $0.bottom.equalTo(self.stepsView[1].snp.top).offset(-5)
            $0.width.equalTo(2)
            $0.height.equalTo(15)
            $0.centerX.equalTo(self.stepsView[0].snp.centerX)
        }
        
        self.stepsView[0].snp.makeConstraints {
            $0.bottom.equalTo(self.lineView[0].snp.top).offset(-5)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        
        self.stepsNumLabel[0].snp.makeConstraints {
            $0.centerX.equalTo(self.stepsView[0].snp.centerX)
            $0.centerY.equalTo(self.stepsView[0].snp.centerY)
        }
        
        self.stepsValueLabel[0].snp.makeConstraints {
            $0.centerY.equalTo(self.stepsView[0].snp.centerY)
            $0.left.equalTo(self.stepsView[0].snp.right).offset(10)
        }
        
        self.stepsView[2].snp.makeConstraints {
            $0.top.equalTo(self.lineView[1].snp.bottom).offset(5)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        
        self.stepsNumLabel[2].snp.makeConstraints {
            $0.centerX.equalTo(self.stepsView[2].snp.centerX)
            $0.centerY.equalTo(self.stepsView[2].snp.centerY)
        }
        
        self.stepsValueLabel[2].snp.makeConstraints {
            $0.centerY.equalTo(self.stepsView[2].snp.centerY)
            $0.left.equalTo(self.stepsView[2].snp.right).offset(10)
        }
        
        self.lineView[2].snp.makeConstraints {
            $0.top.equalTo(self.stepsView[2].snp.bottom).offset(5)
            $0.width.equalTo(2)
            $0.height.equalTo(15)
            $0.centerX.equalTo(self.stepsView[2].snp.centerX)
        }
        
        self.stepsView[3].snp.makeConstraints {
            $0.top.equalTo(self.lineView[2].snp.bottom).offset(5)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        
        self.stepsNumLabel[3].snp.makeConstraints {
            $0.centerX.equalTo(self.stepsView[3].snp.centerX)
            $0.centerY.equalTo(self.stepsView[3].snp.centerY)
        }
        
        self.stepsValueLabel[3].snp.makeConstraints {
            $0.centerY.equalTo(self.stepsView[3].snp.centerY)
            $0.left.equalTo(self.stepsView[3].snp.right).offset(10)
        }
        
    }
}
