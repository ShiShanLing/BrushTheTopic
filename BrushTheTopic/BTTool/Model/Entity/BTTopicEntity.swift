//
//  BTTopicEntity.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/17.
//

import Foundation
import HandyJSON
import WCDBSwift
import SwiftUI

//, HandyJSON, Hashable
//,HandyJSON, Hashable, Codable
struct BTTopicEntity:TableCodable,HandyJSON, Hashable, Codable{
    ///类型-也就是个标签
    var topicType:String = ""
    ///问题
    var topicTitle:String = ""
    ///答案
    var topicAnswer:String = ""
    ///id  UUID().uuidString
    var topicID:String = ""
    ///次数
    var LearnNum:Int = 0
    ///录音路径
    var recordPaths:[String] = [String]()
    ///熟练程度
    var learnLevel = BTlearnLevelEnum.understand.rawValue
    ///当前学习状态
    var currenLearnState = BTlearnLevelEnum.understand.rawValue
    
    
    enum BTlearnLevelEnum:Int {
        ///不认识
        case unfamiliar = 0
        ///眼熟
        case lookFamiliar = 1
        ///了解
        case understand = 2
        ///精通
        case proficient = 3
    }
    
    enum CodingKeys:String, CodingTableKey {
        typealias Root = BTTopicEntity
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case topicType
        case topicTitle
        case topicAnswer
        case topicID
        case LearnNum
        case learnLevel
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
              return [
                topicID: ColumnConstraintBinding(isPrimary: true),
              ]
          }
  
        
    }

}

