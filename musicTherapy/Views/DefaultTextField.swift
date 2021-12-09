//
//  DefaultTextField.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit

class DefaultTextField : UITextField {
    
    override init(frame : CGRect){
        super.init(frame: frame)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup(){
        self.borderStyle = .line
        self.frame = CGRect(x: 10, y: 20, width: self.frame.width - 20, height: 40)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.rightViewMode = .always
        self.clearButtonMode = .whileEditing
        self.textColor = .black
        self.backgroundColor = .clear
    }
    
    func setPlaceholder(_ placeholder : String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
}
