//
//  ColorCollectionViewCell.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

class ColorCollectionViewCell : UICollectionViewCell {
 
    let mainView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(self.mainView)
        
        self.contentView.backgroundColor = .white
        self.mainView.backgroundColor = .white
        self.mainView.layer.cornerRadius = 10
        
        self.mainView.layer.shadowRadius = 5
        self.mainView.layer.shadowOpacity = 0.3
        
        self.setupSubview()
    }
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
    
}
