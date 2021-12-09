//
//  RecommendCollectionViewCell.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

protocol RecommendCollectionViewCellDelegate {
    func onInteractiveClick(index : Int)
}

class RecommendCollectionViewCell : UICollectionViewCell {
    
    private let mainView = UIView()
    private let scaleLabel = UILabel()
    private let feelingLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let notesLabel = UILabel()
    private let interactiveButton = SampleButton()
    
    var cellDelegate : RecommendCollectionViewCellDelegate?
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(self.mainView)
        self.mainView.addSubview(self.scaleLabel)
        self.mainView.addSubview(self.feelingLabel)
        self.mainView.addSubview(self.descriptionLabel)
        self.mainView.addSubview(self.notesLabel)
        self.mainView.addSubview(self.interactiveButton)

        
        self.setupViews()
        
        self.setupSubview()
    }
    
    private func setupViews() {
        self.setupMainView()
        self.setupLabels()
        self.setupButtons()
    }
    
    private func setupMainView() {
        self.contentView.backgroundColor = .white
        self.mainView.backgroundColor = .white
        self.mainView.layer.cornerRadius = 10
        
        self.mainView.layer.shadowRadius = 5
        self.mainView.layer.shadowOpacity = 0.3
    }
    
    private func setupLabels() {
        self.scaleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.scaleLabel.textColor = .black
        self.scaleLabel.textAlignment = .center
        self.feelingLabel.font = UIFont.systemFont(ofSize: 15)
        self.feelingLabel.textColor = .black
        self.feelingLabel.textAlignment = .center
        self.feelingLabel.numberOfLines = 0
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        self.descriptionLabel.textColor = .gray
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .left
        self.notesLabel.textColor = .black
        self.notesLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    private func setupButtons() {
        self.setupInteractiveButton()
    }
    
    private func setupInteractiveButton() {
        self.interactiveButton.mainLabel.text = "🎹"
        self.interactiveButton.mainLabel.textColor = .black
        self.interactiveButton.backgroundColor = .white
        self.interactiveButton.layer.cornerRadius = 10
        self.interactiveButton.layer.shadowRadius = 5
        self.interactiveButton.layer.shadowOpacity = 0.3
        self.interactiveButton.addTarget(self, action: #selector(onInteractiveClick), for: .touchDown)
    }
    
    @objc func onInteractiveClick() {
        cellDelegate?.onInteractiveClick(index: (index?.row)!)
    }
    
    private func setupSubview() {
        
        self.mainView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        self.scaleLabel.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(30)
            $0.centerX.equalTo(self.mainView.snp.centerX)
        }
        
        self.feelingLabel.snp.makeConstraints {
            $0.top.equalTo(self.scaleLabel.snp.bottom).offset(10)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.centerX.equalTo(self.mainView.snp.centerX)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(feelingLabel.snp.bottom).offset(10)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.height.equalTo(120)
        }
        
        self.interactiveButton.snp.makeConstraints {
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
        }
        
        self.notesLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.mainView)
            $0.bottom.equalTo(self.interactiveButton.snp.top).offset(-10)
        }
        
    }
    
    func setupCell(key: MusicalKey?) {
        self.scaleLabel.text = key?.keyName
        self.feelingLabel.text = key?.keyFeel
        self.descriptionLabel.text = key?.keyDescription
        self.notesLabel.text = key?.notes
    }
    
}
