//
//  BTTopicTypeMenu.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/16.
//

import SwiftUI



struct BTTopicTypeMenu: View {

    @Binding var tipicTypeModel:String
    
    @State var typeSelect = false

    
    
    var topicTypes:[BTTopicTypeEntity] = BTWCDB.queryEntityTable(.topicType)
    
//     @State var isShowingSheet = false
    
    
    var body: some View {
        
        Menu.init {
            ForEach.init(topicTypes, id: \.self) { model in
                Button.init(model.topicType) {
                    tipicTypeModel = model.topicType
                }
            }
        } label: {
            HStack{
                Text(tipicTypeModel)
                Image(typeSelect == true ? "BT_addTopic_SL" : "BT_addTopic_XL")
            }
            .frame(width: CGFloat(tipicTypeModel.count * 15) + 30)
        }
        
        .cornerRadius(5)
        .background(Color.yellow)

    }
}
