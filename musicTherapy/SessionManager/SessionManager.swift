//
//  MTSessionManager.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation

class SessionManager {
    
    private let firstLaunchKey = "firstLaunch.key"
    private let userKey = "user.key"
    
    func save(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: self.userKey)
        } catch {
            print("Exeption while saving user")
        }
    }
    
    var user: User? {
        guard let userData = UserDefaults.standard.data(forKey: self.userKey),
            let user = try? JSONDecoder().decode(User.self, from: userData) else { return nil }
        return user
    }
    
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: self.userKey)
    }
    
    func setFirstLaunch() {
        UserDefaults.standard.set(true, forKey: self.firstLaunchKey)
    }
    
    var didFirstLaunch: Bool {
        return UserDefaults.standard.bool(forKey: self.firstLaunchKey)
    }
    
    func logout() {
        self.deleteUser()
    }
}
