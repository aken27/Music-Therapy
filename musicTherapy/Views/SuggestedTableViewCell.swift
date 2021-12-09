//
//  SuggestedTableViewCell.swift
//  musicTherapy
//
//  Created by kkerors on 03.02.2021.
//

import Foundation
import UIKit

protocol SuggestedTableViewCellDelegate {
    func onPlayerClick(index : Int)
    func onVisualClick(index : Int)
//    func onInteractiveClick(index : Int)
}

class SuggestedTableViewCell : UITableViewCell {
    
    private let mainView = UIView()
    private let title = UILabel()
    private let imgView = UIImageView()
    private let playerButton = SampleButton()
    private let visualButton = SampleButton()
//    private let interactiveButton = SampleButton()
    
    var cellDelegate : SuggestedTableViewCellDelegate?
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(self.mainView)
        self.mainView.addSubview(self.title)
        self.mainView.addSubview(self.imgView)
        self.mainView.addSubview(self.playerButton)
        self.mainView.addSubview(self.visualButton)
//        self.mainView.addSubview(self.interactiveButton)
        self.setupViews()
        self.setupSubview()
    }
    
    private func setupViews() {
        self.setupMainView()
        self.setupTitle()
        self.setupImgView()
        self.setupButtons()
    }
    
    private func setupMainView() {
        
        self.contentView.backgroundColor = .white
        self.mainView.backgroundColor = .white
        self.mainView.layer.cornerRadius = 10
        
        self.mainView.layer.shadowRadius = 5
        self.mainView.layer.shadowOpacity = 0.3
        
    }
    
    private func setupTitle() {
        self.title.textColor = .black
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        self.title.sizeToFit()
    }
    
    private func setupImgView() {
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
    }
    
    private func setupButtons() {
        self.setupPlayerButton()
        self.setupVisualButton()
//        self.setupInteractiveButton()
    }
    
    private func setupPlayerButton() {
        self.playerButton.mainLabel.text = "▶️"
        self.playerButton.mainLabel.textColor = .black
        self.playerButton.backgroundColor = .white
        self.playerButton.layer.cornerRadius = 10
        self.playerButton.layer.shadowRadius = 5
        self.playerButton.layer.shadowOpacity = 0.3
        self.playerButton.addTarget(self, action: #selector(onPlayerClick), for: .touchDown)
    }
    
    @objc func onPlayerClick(){
        cellDelegate?.onPlayerClick(index: (index?.row)!)
    }
    
    private func setupVisualButton() {
        self.visualButton.mainLabel.text = "🎆"
        self.visualButton.mainLabel.textColor = .black
        self.visualButton.backgroundColor = .white
        self.visualButton.layer.cornerRadius = 10
        self.visualButton.layer.shadowRadius = 5
        self.visualButton.layer.shadowOpacity = 0.3
        self.visualButton.addTarget(self, action: #selector(onVisualClick), for: .touchDown)
    }
    
    @objc func onVisualClick() {
        cellDelegate?.onVisualClick(index: (index?.row)!)
    }
    
//    private func setupInteractiveButton() {
//        self.interactiveButton.mainLabel.text = "🎹"
//        self.interactiveButton.mainLabel.textColor = .black
//        self.interactiveButton.backgroundColor = .white
//        self.interactiveButton.layer.cornerRadius = 10
//        self.interactiveButton.layer.shadowRadius = 5
//        self.interactiveButton.layer.shadowOpacity = 0.3
//        self.interactiveButton.addTarget(self, action: #selector(onInteractiveClick), for: .touchDown)
//    }
    
//    @objc func onInteractiveClick() {
//        cellDelegate?.onInteractiveClick(index: (index?.row)!)
//    }
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        self.imgView.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(10)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.height.equalTo(45)
            $0.width.equalTo(45)
        }
        self.title.snp.makeConstraints {
            $0.left.equalTo(self.imgView.snp.right).offset(10)
            $0.centerY.equalTo(self.imgView.snp.centerY)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
        }
        self.playerButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.centerX).offset(-5)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
        }
        self.visualButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.centerX).offset(5)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
        }
//        self.interactiveButton.snp.makeConstraints {
//            $0.right.equalTo(self.mainView.snp.right).offset(-10)
//            $0.width.equalTo(90)
//            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-10)
//        }
    }
    
    func setupCell(track : Track) {
        self.title.text = "\(track.author ?? "") - \(track.name ?? "")"
        self.imgView.image = UIImage(named: "Sound")
    }
    
}
