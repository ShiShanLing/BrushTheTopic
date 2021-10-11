//
//  BTTopicTypeEntity.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/22.
//

import Foundation
import HandyJSON
import WCDBSwift

enum BTTopicTypeEnum:String {
    case SwiftUI = "SwiftUI"
    case Swift = "Swift"
    case OC = "OC"
}

struct BTTopicTypeEntity: TableCodable,HandyJSON, Hashable {
    
    var topicType = ""
    
    enum CodingKeys:String, CodingTableKey {
        typealias Root = BTTopicTypeEntity
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case topicType
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
              return [
                topicType: ColumnConstraintBinding(isPrimary: true),
              ]
          }
  
        
    }
    
}
