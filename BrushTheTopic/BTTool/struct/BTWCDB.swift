//
//  BTWCDB.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/18.
//

import Foundation
import WCDBSwift

//@discardableResult

enum BTWCDBEntityEnum:String {
    ///习题
    case topicEntity = "topicEntity"
    ///标题
    case topicType = "topicType"
    ///每天随机习题
    case randomLearnTopic = "randomLearnTopic"
    ///测试用
    case Test = "Test"
    
    func entityTable() -> String {
      return "\(self.rawValue)Table"
//        switch self {
//        case .topicEntity:
//            return "\(self.rawValue)Table"
//        case .topicType:
//            return "\(self.rawValue)Table"
//        case .randomLearnTopic:
//            return "\(self.rawValue)Table"
//        }
    }

    
}

struct BTWCDB {
    //MARK:获取管理对象
    ///获取管理对象
   static func database(_ entity:BTWCDBEntityEnum) -> Database {
        return Database(withPath: self.dataBasePath(entity))
    }

    ///获取存储路径
    static func dataBasePath(_ entity:BTWCDBEntityEnum) -> String {
        return "\(wcdbCacheTablePath)/\(entity.rawValue).db"
    }
    //MARK:创建数据库
    ///创建数据库
    static func createDatabase<Object: TableDecodable>(_ entity:BTWCDBEntityEnum, of rootType: Object.Type) {
        
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
    //MARK:增
    /// 插入数据
    /// - Parameters:
    ///   - entity: 插入的实体类型<影响到你插入到哪张表>
    ///   - objects: 对象数组
    static func insertData<Object: TableEncodable>(_ entity:BTWCDBEntityEnum, objects:[Object], closure:BTCommonClosure<Bool>? = nil) {
        
        do {
            
            try BTWCDB.database(entity).insertOrReplace(objects: objects, intoTable: entity.entityTable())
            closure?(true)
        } catch let error {
            closure?(false)
            print("插入数据库失败", error)
        }
    }
    //MARK:改
    static func update<Object: TableEncodable>(_ entity:BTWCDBEntityEnum,on propertyConvertibleList: [PropertyConvertible], object:Object,condition: Condition?,  closure:BTCommonClosure<Bool>? = nil) {
        do {
            try BTWCDB.database(entity).update(table: entity.entityTable(),on: propertyConvertibleList, with: object, where: condition)
            closure?(true)
        } catch let error {
            closure?(false)
            print("更新数据库失败", error)
        }
    }
    
    //MARK:查
    /// 查表中所有的数据
    /// - Returns: 返回对象
    static func queryEntityTable<object: TableEncodable>(_ entity:BTWCDBEntityEnum) -> [object] where object : WCDBSwift.TableDecodable {
        do {
            let  object:[object] = try BTWCDB.database(entity).getObjects(fromTable: entity.entityTable())
            return object
        } catch let error {
            print("查询失败\(error)")
        }
        return []
    }
     
    
    static func delectEntity(entity:BTWCDBEntityEnum, condition: Condition? = nil, closure:BTCommonClosure<Bool>? = nil) {
        do {
            try BTWCDB.database(entity).delete(fromTable: entity.entityTable(), where: condition)
            closure?(true)
        } catch let error {
            print("删除数据库失败\(error)")
            closure?(false)
        }
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
