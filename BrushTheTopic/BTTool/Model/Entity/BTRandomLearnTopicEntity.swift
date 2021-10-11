//
//  BTRandomLearnTopicEntity.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/10/9.
//

import Foundation
import WCDBSwift
import HandyJSON

struct BTRandomLearnTopicEntity:TableCodable, HandyJSON{
    var LearnId = ""
    
    var topics = [BTTopicEntity]()
    
    enum CodingKeys:String, CodingTableKey {
        typealias Root = BTRandomLearnTopicEntity
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case LearnId
        case topics
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
              return [
                LearnId: ColumnConstraintBinding(isPrimary: true),
              ]
          }
  
        
    }
}
