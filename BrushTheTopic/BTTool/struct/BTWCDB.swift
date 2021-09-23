//
//  BTWCDB.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/18.
//

import Foundation
import WCDBSwift


enum BTWCDBEntityEnum:String {
    ///习题
    case BTTopicEntity = "BTTopicEntity"
    ///标题
    case BTTopicTitle = "BTTopicTitle"
    
    func entityTable() -> String {
        switch self {
        case .BTTopicEntity:
            return "\(self.rawValue)Table"
        case .BTTopicTitle:
            return "\(self.rawValue)Table"
        }
    }
}
var globaWCDB = BTWCDB()

struct BTWCDB {
    //MARK:获取管理对象
    ///获取管理对象
   static func database(_ entity:BTWCDBEntityEnum) -> Database {
        return Database(withPath: self.dataBasePath(entity))
    }

    ///获取存储路径
    static func dataBasePath(_ entity:BTWCDBEntityEnum) -> String {
        //存储路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                      .userDomainMask,
                                                                      true).last!
        return "\(path)/\(entity.rawValue).db"
    }
    //MARK:创建数据库
    ///创建数据库
    mutating func createDatabase<Object: TableDecodable>(_ entity:BTWCDBEntityEnum, of rootType: Object.Type) {
        //创建数据库表
        if !FileManager.default.fileExists(atPath: BTWCDB.dataBasePath(entity)) {
            // 以下代码等效于 SQL：CREATE TABLE IF NOT EXISTS sampleTable(identifier INTEGER, description TEXT)
            do {
                try BTWCDB.database(entity).create(table: entity.entityTable(), of: rootType)
            } catch let error {
                print("创建数据库对象失败", error)
            }
        }else {
            print("文件路径已存在\(BTWCDB.dataBasePath(entity))")
        }
    }
    //MARK:插入数据
    /// 插入数据
    /// - Parameters:
    ///   - entity: 插入的实体类型<影响到你插入到哪张表>
    ///   - objects: 对象数组
    mutating func insertData<Object: TableEncodable>(_ entity:BTWCDBEntityEnum, objects:[Object]) {
        
        do {
            try BTWCDB.database(entity).insertOrReplace(objects: objects, intoTable: entity.entityTable())
        } catch let error {
            print("插入数据库失败", error)
        }
    }
    
    mutating func queryEntityTable<object: TableEncodable>(_ entity:BTWCDBEntityEnum) -> [object] where object : WCDBSwift.TableDecodable {
        do {
            return try BTWCDB.database(entity).getObjects(fromTable: entity.entityTable())
        } catch let error {
            print("查询失败\(error)")
        }
        return []
    }
    
    
    func delectEntity(_ models:[BTTopicEntity], entity:BTWCDBEntityEnum, condition: Condition? = nil) {
        
//        do {
//            try database.delete(fromTable: <#T##String#>, where: <#T##Condition?#>, orderBy: <#T##[OrderBy]?#>, limit: <#T##Limit?#>, offset: <#T##Offset?#>)
//        } catch let error {
//            print("删除数据库失败\(error)")
//        }
    }
    
    func delectEntityTable(_ entity:BTWCDBEntityEnum) {
        let database = BTWCDB.database(entity)
        do {
            try database.delete(fromTable: entity.entityTable())
        } catch let error {
            print("删除数据库失败\(error)")
        }
        
    }
    
}
