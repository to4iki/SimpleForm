//
//  SettingContext.swift
//  SimpleForm
//
//  Created by to4iki on 1/13/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import Foundation

enum SettingMode: String {
    
    case NickName = "nickName"
    case Password = "password"
    case Sex = "sex"
    case Birthday = "birthday"
    
    private var suffix: String {
        switch self {
        case .Sex, .Birthday: return "create"
        default: return "edit"
        }
    }
    
    var textFieldPlaceholder: String {
        switch self {
        case .Sex, .Birthday: return self.rawValue
        default: return "new \(self.rawValue)"
        }
    }
    
    func toNavigationTitle() -> String {
        return "\(self.rawValue) \(suffix)"
    }
    
    static func getInstanceByIndexPath(indexPath: NSIndexPath) -> SettingMode? {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return .NickName
        case (0, 1): return .Password
        case (1, 0): return .Sex
        case (1, 1): return .Birthday
        default: return nil
        }
    }
}

struct SettingFormViewScope {
    var nickName: String? = nil
    var password: String? = nil
    var sex: String? = nil
    var birthday: NSDate? = nil
}
