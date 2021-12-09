//
//  RegisterViewController.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit
import SnapKit
import Firebase

class RegisterViewController: UIViewController {

    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let loginTextField = DefaultTextField()
    private let passwordTextField = DefaultTextField()
    private let repeatPasswordTextField = DefaultTextField()
    private let registerButton = SampleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Register")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.loginTextField)
        self.mainView.addSubview(self.passwordTextField)
        self.mainView.addSubview(self.repeatPasswordTextField)
        self.mainView.addSubview(self.registerButton)
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupLoginTextField()
        self.setupPasswordTextField()
        self.setupRepeatPasswordTextField()
        self.setupLoginButton()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupLoginTextField(){
        self.loginTextField.setPlaceholder("Email")
        self.loginTextField.keyboardType = .emailAddress
    }
    
    private func setupPasswordTextField(){
        self.passwordTextField.setPlaceholder("Password")
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.keyboardType = .default
    }
    private func setupRepeatPasswordTextField(){
        self.repeatPasswordTextField.setPlaceholder("Confirm Password")
        self.repeatPasswordTextField.isSecureTextEntry = true
        self.repeatPasswordTextField.keyboardType = .default
    }
    
    private func setupLoginButton() {
        self.registerButton.mainLabel.text = "Submit"
        self.registerButton.mainLabel.textColor = .white
        self.registerButton.backgroundColor = .black
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.layer.masksToBounds = true
        self.registerButton.addTarget(self, action: #selector(onRegisterClick), for: .touchDown)
    }
    
    @objc func onRegisterClick(){
        createUser(loginTextField.text, passwordTextField.text, repeatPasswordTextField.text)
    }
    
    private func validatePassword(_ passOne: String?, _ passTwo: String?) -> Bool{
        if passOne == passTwo {
            return true
        }
        return false
    }
    
    private func createUser(_ login: String?, _ passOne: String?, _ passTwo: String?) {
        if validatePassword(passOne, passTwo) && login != "" && passOne != "" {
            Auth.auth().createUser(withEmail: login!, password: passOne!) { (user, error) in
                if error != nil {
                    print(error)
                } else {
                    print(user)
                    MainTabBarRouting.presentMainTabBarViewController(fromVC: self)
                }
            }
        }
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.loginTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.mainView.snp.top).offset(70)
        }
        self.passwordTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.loginTextField.snp.bottom).offset(30)
        }
        self.repeatPasswordTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(30)
        }
        self.registerButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.height.equalTo(56)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
