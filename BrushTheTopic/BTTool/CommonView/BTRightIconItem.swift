//
//  BTRightIconItem.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/16.
//

import SwiftUI


struct BTRightIconItem: View {
    
    init(closure:@escaping BTCommonClosure<BTTopicTypeEntity>) {
        self.closure = closure
    }
    
    @State private var typeSelect = false
    
    @State private var contentText = "请选择"
    
    var closure:BTCommonClosure<BTTopicTypeEntity>
    
    private var topicTypes:[BTTopicTypeEntity] = BTWCDB.queryEntityTable(.topicType)
    
    var body: some View {
        
        Menu.init {
            ForEach.init(topicTypes, id: \.self) { model in
                Button.init(model.topicType) {
                    contentText = model.topicType
                    closure(model)
                }
            }
        } label: {
            HStack{
                Text(contentText)
                Image(typeSelect == true ? "BT_addTopic_SL" : "BT_addTopic_XL")
            }
        }
        .cornerRadius(5)
        .background(Color.yellow)

    }
}

struct BTRightIconItem_Previews: PreviewProvider {
    static var previews: some View {
        BTRightIconItem.init { model in
            
        }
    }
}
