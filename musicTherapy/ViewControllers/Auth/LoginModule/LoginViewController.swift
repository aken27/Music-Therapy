//
//  LoginViewController.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit
import Firebase
import SnapKit

class LoginViewController: UIViewController {

    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let loginTextField = DefaultTextField()
    private let passwordTextField = DefaultTextField()
    private let loginButton = SampleButton()
    private let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Authorization")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.loginTextField)
        self.mainView.addSubview(self.passwordTextField)
        self.mainView.addSubview(self.registerButton)
        self.mainView.addSubview(self.loginButton)
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupLoginTextField()
        self.setupPasswordTextField()
        self.setupLoginButton()
        self.setupRegisterButton()
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
        self.passwordTextField.keyboardType = .default
        self.passwordTextField.isSecureTextEntry = true
    }
    
    private func setupLoginButton() {
        self.loginButton.mainLabel.text = "Login"
        self.loginButton.mainLabel.textColor = .white
        self.loginButton.backgroundColor = .black
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.layer.masksToBounds = true
        self.loginButton.addTarget(self, action: #selector(onLoginClick), for: .touchDown)
    }
    
    private func setupRegisterButton() {
        self.registerButton.setTitle("Register", for: .normal)
        self.registerButton.setTitleColor(.gray, for: .normal)
        self.registerButton.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        self.registerButton.addTarget(self, action: #selector(onRegisterClick), for: .touchDown)
    }
    
    @objc func onRegisterClick(sender: UIButton!) {
        RegisterRouting.presentRegisterViewController(fromVC: self)
    }
    
    @objc func onLoginClick(sender: UIButton) {
        validateLogin(self.loginTextField.text, self.passwordTextField.text)
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.loginTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.mainView.snp.top).offset(170)
        }
        self.passwordTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.loginTextField.snp.bottom).offset(30)
        }
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalTo(self.mainView.snp.centerX)
        }
        self.loginButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.height.equalTo(56)
        }
    }
    
    private func validateLogin(_ login: String?, _ password: String?) {
        if login != "" && password != "" {
            signIn(login, password)
        } else {
            print("Error")
        }
    }
    
    private func signIn(_ login: String?, _ password: String?) {
        Auth.auth().signIn(withEmail: login!, password: password!) { (user, error) in
            if error != nil {
//                print(error)
            } else {
//                print(user)
                MainTabBarRouting.presentMainTabBarViewController(fromVC: self)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
