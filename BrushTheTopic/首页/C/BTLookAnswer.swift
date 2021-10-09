//
//  BTLookAnswer.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/10/8.
//

import SwiftUI
///答题结束查看答案界面
struct BTLookAnswer: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var topicTypeModel = BTTopicTypeEntity(topicType: "请选择")
    
    @State var topicModel:BTTopicEntity
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    
                    Text(topicModel.topicTitle)
                        .frame(width: SCREEN_WIDTH-60, height: 30, alignment: .leading)
                    
                    TopicTypeSelectView(topicType: $topicTypeModel.topicType)
                    .padding(.leading, 15.0)
                    .padding(.top, 25)
                    
                    Text("答案:")
                        .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                    BTTextEditor(TVtext: $topicModel.topicAnswer)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .frame(width: SCREEN_WIDTH-60, height: 100, alignment: .leading)
                         
                }

                //这个要在navigation内部隐藏
                .navigationBarHidden(true)

            }
            
            
            
         
        }
        .foregroundColor(.blue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)//隐藏系统返回按钮
        .navigationBarItems(leading:
                                Button.init(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Label.init("返回", image: "BT_return")
                                })
        )
        
    }
}

struct BTLookAnswer_Previews: PreviewProvider {
    static var previews: some View {
        BTLookAnswer(topicModel:BTWCDB.queryEntityTable(.topicEntity)[0])
    }
}
