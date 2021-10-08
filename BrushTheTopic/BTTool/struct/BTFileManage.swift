//
//  BTFileManage.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/29.
//

import Foundation

fileprivate let appCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last ?? ""

var wcdbCacheTablePath:String {
    get {
        "\(appCachePath)/WCDBTable"
    }
}

var recordingCachePath:String {
    get {
        "\(appCachePath)/recording"
    }
}




struct BTFileManage {
    //需要一个判断改路径是否存在的方法
    static func fileExists(atPath:String) -> Bool {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: atPath) {
            do {
                try fileManager.createDirectory(atPath: atPath, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch let tError {
                print("checkFilePath==\(tError)")
                return false
            }
        }else {
            return true
        }
        
    }
    
}
