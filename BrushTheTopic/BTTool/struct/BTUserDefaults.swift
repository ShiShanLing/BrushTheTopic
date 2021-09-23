//
//  BTUserDefaults.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/22.
//

import Foundation

enum BTUserDefaultsGetKeyEnum:String {
    //题库
    case localTopicStored = "localTopicStored"
    //问题类型
    case topicTypeStored = "topicTypeStored"
}

struct BTUserDefaults {
    
    static let userDefaults = UserDefaults.standard
    
    //需要加一个本地数据是否已经导入的判断函数.
    
    /// 写入本地数据已存储
    /// - Parameters:
    ///   - state: 默认本地数据存储成功
    ///   - return: 同步成功回调 默认可以不实现
    
    static func writeState(type:BTUserDefaultsGetKeyEnum, state:Bool = true) -> Bool {
        userDefaults.setValue(true, forKey: type.rawValue)
        return userDefaults.synchronize()
    }
    
    static func readState<T>(type:BTUserDefaultsGetKeyEnum, TType:T.Type) -> T? {
        return userDefaults.value(forKey: type.rawValue) as? T
    }
    
}
