//
//  BTTopicEntity.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/17.
//

import Foundation
import HandyJSON
import WCDBSwift

//, HandyJSON, Hashable
struct BTTopicEntity: TableCodable,HandyJSON, Hashable{
    ///类型-也就是个标签
    var topicType = ""
    ///问题
    var topicTitle = ""
    ///答案
    var topicAnswer = ""
    ///id  UUID().uuidString
    var topicID = ""
    ///次数
    var LearnNum:Int = 0
    ///录音路径
    var recordPaths:[String] = []
    
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

