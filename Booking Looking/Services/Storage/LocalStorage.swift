//
//  LocalStorage.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import Foundation
import Combine


enum LocalStorageKey: String {
    case token
    case ID
    case isComplited
}

struct LocalStorage {
    
    private let userDefaults = UserDefaults.standard
    
    static var current = LocalStorage()
    
    private init(){}
    
    var ID: Int {
        get {
            userDefaults.integer(forKey: LocalStorageKey.ID.rawValue)
        }
        set{
            userDefaults.set(newValue, forKey: LocalStorageKey.ID.rawValue)
        }
    }
    
    var token: String {
        get {
            userDefaults.string(forKey: LocalStorageKey.token.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: LocalStorageKey.token.rawValue)
        }
    }

    var isComplited: Bool {
        get {
            userDefaults.bool(forKey: "isComplited")
        }
        set {
            userDefaults.setValue(newValue, forKey: "isComplited")
        }
    }
}
