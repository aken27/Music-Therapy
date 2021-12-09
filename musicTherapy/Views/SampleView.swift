//
//  SampleView.swift
//  musicTherapy
//
//  Created by kkerors on 13.05.2021.
//

import Foundation
import UIKit

class SampleView : UIView {
    
    var mainLabel = UILabel()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup(){
        self.addSubview(self.mainLabel)
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.mainLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
