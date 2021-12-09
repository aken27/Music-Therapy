//
//  ButtonView.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit

class SampleButton : UIButton {
    
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
        self.addTarget(self, action: #selector(self.buttonPressed), for: .touchDown)
        self.setupConstraints()
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1,
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.transform = CGAffineTransform.identity
                }
            })
    }
    
    func setupConstraints(){
        self.mainLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
