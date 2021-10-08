//
//  BTTopicApi.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/18.
//

import Foundation


struct BTTopicApi {
    ///导入本地的数据
    static func importLocalData() -> [BTTopicEntity]{
        guard let filePath = Bundle.main.path(forResource: "Topic", ofType: "plist"),let dicArray = NSArray(contentsOf: URL(fileURLWithPath: filePath)) as? [[String:Any]] else {
            return []
        }
        var  topicArray = [BTTopicEntity]()
        
        for i in 0..<dicArray.count {
            let tempDic = dicArray[i]

            topicArray.append(BTTopicEntity.deserialize(from: tempDic) ?? BTTopicEntity())
        }
        return topicArray
    }
    
    static func importTopicTitle() -> [BTTopicTypeEntity]{
        let tempArray = ["Swift", "OC", "SwiftUI"]
        var models = [BTTopicTypeEntity]()
        for str in tempArray {
            var model = BTTopicTypeEntity()
            model.topicType = str
            models.append(model)
        }
        return models
    }
    

}

