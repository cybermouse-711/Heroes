//
//  DateManager.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 27.08.24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setFavoriteStatus(for name: String, with status: Bool) {
        userDefaults.set(status, forKey: name)
    }
    
    func getFavoriteStatus(for name: String) -> Bool {
        userDefaults.bool(forKey: name)
    }
}

