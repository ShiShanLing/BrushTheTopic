//
//  BTRightIconItem.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/16.
//

import SwiftUI

struct BTRightIconItem: View {
    
    @State var typeSelect = false
    
    @State var contentText = "请选择"
    
    var closure:BTCommonClosure<String>?
    
    var topicTypes:[String]
    
    var body: some View {
        
        Menu.init {
            ForEach.init(topicTypes, id: \.self) { Str in
                Button.init(Str) {
                    contentText = Str
                    closure?(Str)
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
        BTRightIconItem(closure: { Str in
            print("")
        }, topicTypes:["OC", "Swift", "SwiftUI"])
    }
}
