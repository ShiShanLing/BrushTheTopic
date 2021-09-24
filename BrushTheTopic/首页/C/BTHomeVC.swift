//
//  BTHomeVC.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/8.
//

import SwiftUI
import UIKit

struct BTHomeVC: View {
    
    @State var searchIsActive = false
    var body: some View {
        NavigationView {
            ZStack {
                HomeBackgroundImageView()
                    .frame(width: SCREEN_WIDTH, height: SCREEN_HEIGHT, alignment: .center)
                VStack{
                    Spacer()
                    Spacer()
                    Text("您已经进行了N天,打了N个怪兽")
                        .padding(.all)
                        .foregroundColor(.white)
                    Text("您已经进行了N天,打了N个怪兽.您已经进行了N天,打了N个怪兽.")
                        .padding(.all)
                        .foregroundColor(.white)
                    Spacer()
                    Button.init("开始") {
                        
                    }
                    .frame(width: 100, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    Spacer()
                    Spacer()
                }
                .padding(.top, 0)
            }
            .navigationBarItems(trailing: HomeNavigationView())
        }
        .onAppear(perform: {
            insertLocalTopic()
        })
    }
    
    func insertLocalTopic() {

        BTWCDB.createDatabase(.topicEntity, of: BTTopicEntity.self)
        if !(BTUserDefaults.readState(type: .localTopicStored, TType: Bool.self) ?? false) {
            BTWCDB.insertData(.topicEntity, objects: BTTopicApi.importLocalData())
            let _ = BTUserDefaults.writeState(type: .localTopicStored)
        }
        let modelArray:[BTTopicEntity] = BTWCDB.queryEntityTable(.topicType)
        
        BTWCDB.createDatabase(.topicType, of: BTTopicTypeEntity.self)
        if !(BTUserDefaults.readState(type: .topicTypeStored, TType: Bool.self) ?? false) {
            BTWCDB.insertData(.topicType, objects: BTTopicApi.importTopicTitle())
            let _ = BTUserDefaults.writeState(type: .topicTypeStored)
        }
    }
    
    
    func testFunc<T>(TType:T.Type) -> T? {
        
        let tempAny:Any? = ["name":"石"]
        
        return tempAny as? T
    }

    
}

struct HomeBackgroundImageView : View{
    var body: some View {
        ZStack{
            Image("BT_Home_Bg")
                .aspectRatio(contentMode:.fit)
            Color.black
                .opacity(0.4)
        }
    }
}


struct HomeNavigationView : View{
    
    @State var searchIsActive = false
    
    var body: some View {
        
        HStack {
            Spacer()
            
            NavigationLink.init(
                destination: AddTopicView(),
                label: {
                    Label.init(
                        title: { Text("").foregroundColor(.white) },
                        icon: { Image.init("BT_home_add")}
                    )
                    .foregroundColor(.blue)
                    .frame(height:44)
                    .padding(.trailing)
                })
            
            NavigationLink.init(
                destination: BTSearchTopicView(),
                label: {
                    Label.init(
                        title: { Text("").foregroundColor(.white) },
                        icon: { Image.init("BT_home_search")}
                    )
                    .foregroundColor(.blue)
                    .frame(height:44)
                    .padding(.trailing)
                })
        
        }
    }
}

struct BTHomeVC_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            BTHomeVC()
            HomeBackgroundImageView()
            HomeNavigationView()
        }
        
        
    }
}
