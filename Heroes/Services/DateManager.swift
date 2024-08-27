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
    
    func setFavoriteStatus(for id: Int, with status: Bool) {
        userDefaults.set(status, forKey: String(id))
    }
    
    func getFavoriteStatus(for id: Int) -> Bool {
        userDefaults.bool(forKey: String(id))
    }
}

