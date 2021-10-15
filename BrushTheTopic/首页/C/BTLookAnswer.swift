//
//  BTLookAnswer.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/10/8.
//

import SwiftUI
import WCDBSwift
///答题结束查看答案界面
struct BTLookAnswer: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var topicModel:BTTopicEntity
    ///用户的文字答案
    @State var userTextAnswer:String = "123"
    ///用户的语音答案录音路径
    @State var userRecordingAnswer:String
    
    @State var totalTimer:Float = 100
    
    @State var palyTimer:Float = 100
    
    @State var isNextAnswerActive = false
    
    @State var isLearnEndActive = false
    
    var body: some View {
        VStack {
            
            ScrollView(showsIndicators: false){
                Spacer.init(minLength: kNavigationBarXExtraHeight)
                Text(topicModel.topicTitle)
                    .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                //
                Text("题目类型:\(topicModel.topicType)")
                    .padding(.vertical)
                    .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                
                Text("标准答案:")
                    .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                
                Text(topicModel.topicAnswer)
                    .padding(.all)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                
                if userRecordingAnswer.count != 0 {
                    Text("本次语音答题内容:")
                        .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                    BTRecordingPalyView(totalTimer: $totalTimer, palyTimer: $palyTimer) { _ in
                        //play
                        audioPlayer.playRecording { (duration: Float, currentTime: Float) in
                            totalTimer = duration
                            palyTimer = currentTime
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer(minLength: 50)
                Button {
                    self.topicModel.learnLevel = 0
                    handleTopicLearnProcess()
                    isNextAnswerActive.toggle()
                } label: {
                    Text("标记为不会")
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 40, alignment: .center)
                .background(Color.red)
                .cornerRadius(8)
                
                Spacer(minLength: 50)
                
            }
            
            .fullScreenCover(isPresented: $isNextAnswerActive) {
                
            } content: {
                BTStartLearning()
            }
            
            //这个要在navigation内部隐藏
            .navigationBarHidden(true)
            Button {
                self.topicModel.learnLevel += 1
                //存进题库
                handleTopicLearnProcess()
                //更新当天学习进度
                updateTodayLearnDatabase()
                //如果是空说明已经结束
                if BTTopicApi.getLearnTopic() == nil {
                    isLearnEndActive = true
                    return
                }
                isNextAnswerActive.toggle()
            } label: {
                Text("下一题")
                    .foregroundColor(.white)
            }
            .foregroundColor(.white)
            .frame(width: 80, height: 40, alignment: .center)
            .background(Color.blue)
            .cornerRadius(8)

            
        }
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)//隐藏系统返回按钮
        
        .onAppear {
            //在这里初始化播放器,并获取语音时长
            totalTimer = 39
            palyTimer = 0
        }
        .onDisappear {
            
        }
        
    }
    
    
    //更新当前学习题目库
    func updateTodayLearnDatabase() {
        do {
            let currenDate = Date().dateToString("yyyy-MM-dd")
            let models:[BTRandomLearnTopicEntity] = try BTWCDB.database(.randomLearnTopic).getObjects(fromTable: BTWCDBEntityEnum.randomLearnTopic.entityTable(), where: BTRandomLearnTopicEntity.Properties.LearnId == currenDate)
            
            
            guard let learnModel = models.first else {
                return
            }
            
            var tempLearnModel = learnModel
            
            var topics = tempLearnModel.topics
            
            
            for (index, model) in topics.enumerated() {
                if model.topicID == self.topicModel.topicID {
                    topics[index] = model
                }
            }
            tempLearnModel.topics = topics
            
            BTWCDB.update(.randomLearnTopic, on: [BTRandomLearnTopicEntity.Properties.topics], object: tempLearnModel, condition: tempLearnModel.LearnId == currenDate, closure: nil)
            
        } catch let getError {
            
        }
        
    }
    
    //已经学习完成吧他存进大数据库
    func handleTopicLearnProcess() {
        
        if self.topicModel.currenLearnState >= 3 {
            self.topicModel.learnLevel += 1
            self.topicModel.LearnNum += 1
            //存进大数据库
            BTWCDB.update(.topicEntity, on:  [BTTopicEntity.Properties.topicTitle, BTTopicEntity.Properties.topicAnswer], object: self.topicModel, condition: BTTopicEntity.Properties.topicID == self.topicModel.topicID) { result in
                //更新结果
                print("更新-->\(result ? "成功":"失败")")
            }
        }
        
    }
    
}
