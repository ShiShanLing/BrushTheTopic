//
//  BTTopicApi.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/18.
//

import Foundation
import WCDBSwift
///学习题目数量 默认是10
var learnTopicNum = 10

struct BTTopicApi {
    
    //每天learnTopicNum道题怎么设计?
    /*
     创建一个新的实体类..实体类的id为当前的年月日 实体类的对象为随机的题目.
     调用 learnTopicNum 时 通过今天的年月日搜索这个实体类,搜索不到的话,就去数据库里面随机拿出10个未学习过的题目.生成实体类 吧数据库清空之后然后存进数据库.
     然后
     */
    ///返回值是空说明学习结束
    static func getLearnTopic() -> BTTopicEntity?{
        let currenDate = Date().dateToString("yyyy-MM-dd")
        do {
            let models:[BTRandomLearnTopicEntity] = try BTWCDB.database(.randomLearnTopic).getObjects(fromTable: BTWCDBEntityEnum.randomLearnTopic.entityTable(), where: BTRandomLearnTopicEntity.Properties.LearnId == currenDate)
            //如果是空的
            var randomLearnTopicEntity = BTRandomLearnTopicEntity()
            if models.count == 0 {//如果是空的就通过randomTopic随机得到 learnTopicNum道题保存到数据库
                let newMoels = randomTopic()
                randomLearnTopicEntity.LearnId = currenDate
                randomLearnTopicEntity.topics = newMoels
                ///存进去
                BTWCDB.insertData(.randomLearnTopic, objects: [randomLearnTopicEntity]) { result in
                    
                }
            }else{//如果不是空就取出来
                randomLearnTopicEntity = models.first!
            }
            //得到今天随机的题目列表之后再熟练度最低的题目里面随机取出一个道
            return getLearnTopic(topicIds: randomLearnTopicEntity.topics)
        } catch let errors {
            
        }
        return nil
    }
    ///随机获取题目
    static func randomTopic() -> [BTTopicEntity]  {
        do {
             var models:[BTTopicEntity] = try BTWCDB.database(.topicEntity).getObjects(fromTable: BTWCDBEntityEnum.topicEntity.entityTable(), where: BTTopicEntity.Properties.learnLevel == 0)
            if models.count < learnTopicNum {
                let modelsTwo:[BTTopicEntity] = try BTWCDB.database(.topicEntity).getObjects(fromTable: BTWCDBEntityEnum.topicEntity.entityTable(), where: BTTopicEntity.Properties.learnLevel == 1)
                models += modelsTwo
            }
            if models.count < learnTopicNum {
                let modelsTwo:[BTTopicEntity] = try BTWCDB.database(.topicEntity).getObjects(fromTable: BTWCDBEntityEnum.topicEntity.entityTable(), where: BTTopicEntity.Properties.learnLevel == 2)
                models += modelsTwo
            }
            if models.count < learnTopicNum {
                let modelsTwo:[BTTopicEntity] = try BTWCDB.database(.topicEntity).getObjects(fromTable: BTWCDBEntityEnum.topicEntity.entityTable(), where: BTTopicEntity.Properties.learnLevel == 3)
                models += modelsTwo
            }
            if models.count > learnTopicNum {
                models = models.dropLast(models.count - learnTopicNum)
            }
            
            print("models==\(models.count)")
            return models.map { model in
                var tempModel = model
                tempModel.currenLearnState = 0
                return tempModel
            }
        } catch _ {
            
        }
        
        return []
    }
    
    ///从今天需要学习的题目,列表里面随机拿出一道题 如果返回值为空说明学习结束
    static func getLearnTopic(topicIds:[BTTopicEntity]) -> BTTopicEntity? {
        
        var tempModels = topicIds.filter { $0.currenLearnState < 2 }
        
        if tempModels.count == 0 {
            tempModels = topicIds.filter { $0.currenLearnState <= 3 }
        }
        
        if tempModels.count == 0 {
            return nil
        }
        
        let random = Int(arc4random()) % tempModels.count
        return tempModels[random]
        
        
    }
    
    
    
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

