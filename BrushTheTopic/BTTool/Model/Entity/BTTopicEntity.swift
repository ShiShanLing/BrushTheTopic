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
    var learnLevel:BTlearnLevelEnum = .understand
    
    enum BTlearnLevelEnum {
        ///不认识
        case unfamiliar
        ///眼熟
        case lookFamiliar
        ///了解
        case understand
        ///精通
        case proficient
    }
    
    enum CodingKeys:String, CodingTableKey {
        typealias Root = BTTopicEntity
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case topicType
        case topicTitle
        case topicAnswer
        case topicID
        case LearnNum
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
              return [
                topicID: ColumnConstraintBinding(isPrimary: true),
              ]
          }
  
        
    }

}

