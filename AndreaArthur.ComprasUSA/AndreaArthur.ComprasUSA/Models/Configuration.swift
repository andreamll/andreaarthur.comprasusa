//
//  Configuration.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 22/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case usdValue = "usdValue"
    case iofValue = "iofValue"
}

class Configuration {
    
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var usdValue: Double {
        get{
            return defaults.double(forKey: UserDefaultsKeys.usdValue.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.usdValue.rawValue)
        }
    }
    
    var iofValue: Double {
        get{
            return defaults.double(forKey: UserDefaultsKeys.iofValue.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.iofValue.rawValue)
        }
    }
    
    private init() {
        if defaults.double(forKey: UserDefaultsKeys.usdValue.rawValue) == 0 {
            defaults.set(5.20, forKey: UserDefaultsKeys.usdValue.rawValue)
        }
        
        if defaults.double(forKey: UserDefaultsKeys.iofValue.rawValue) == 0 {
            defaults.set(6.38, forKey: UserDefaultsKeys.iofValue.rawValue)
        }
    }
}
