//
//  AddTopicView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/15.
//

import SwiftUI
import WCDBSwift



struct AddTopicView: View {
    
    enum AddViewTypeEnum {
        //添加
        case Add
        //编辑
        case Editor
    }
    
    @Environment(\.presentationMode) var presentationMode
    @State var viewType:AddViewTypeEnum = .Add
    @State var showingDetail = false
    @State var topicTitle = "石山岭"
    @State var topicAnswer = "123"
    @State var isCanSubmit = false
    @State var topicTypeModel = BTTopicTypeEntity(topicType: "请选择")
    ///如果是编辑问题需要传这个值进来
    @State var topicID = ""
    @State var addActionSheet = false
    @State var actionStr = ""
    @State var isSaveSuccess = false
    var body: some View {
        NavigationView {
            
            VStack {
                ScrollView{
                    TopicTypeSelectView(topicType: $topicTypeModel.topicType)
                    .padding(.leading, 15.0)
                    .padding(.top, 25)
                    
                    Text("填写题目:")
                        .frame(width: SCREEN_WIDTH-60, height: 30, alignment: .leading)
                    BTTextEditor(TVtext: $topicTitle)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .frame(width: SCREEN_WIDTH-60, height: 100, alignment: .leading)
                    
                    Text("填写答案:")
                        .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                    BTTextEditor(TVtext: $topicAnswer)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .frame(width: SCREEN_WIDTH-60, height: 100, alignment: .leading)
                         
                }

                //这个要在navigation内部隐藏
                .navigationBarHidden(true)
                Button.init {
                    //添加同时添加提示
                    actionStr = ""
                    if topicTypeModel.topicType.count == 0 || topicTypeModel.topicType == "请选择" {
                        actionStr = "请选择题目类型"
                    }else if topicTitle.count == 0 {
                        actionStr = "请输入题目"
                    }else if topicAnswer.count == 0 {
                        actionStr = "请输入答案"
                    }
                    if actionStr.count == 0 {
                        saveTopic()
                    }else{
                        addActionSheet.toggle()
                    }
                } label: {
                    Label.init {
                        Text(self.viewType == .Add ? "添加":"保存")
                    } icon: {
                        
                        Image(self.viewType == .Add ? "BT_home_add":"BT_save")
                    }
                }
                .frame(width: 100, height: 40)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .alert(isPresented: $addActionSheet){
                    Alert.init(title: Text("提示"), message: Text(actionStr), dismissButton: .default(Text("OK"), action: {
                        if isSaveSuccess == true {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }))
                }
                                                                                                    
//                .actionSheet(isPresented: $addActionSheet) {
//                    ActionSheet.init(title: Text("提示"), message: Text(actionStr), buttons: [
//                        .destructive(Text("知道了"), action: {
//
//                        }),
//                        .cancel()
//                    ])
//                }
                Spacer(minLength: 50)
            }
            
            
            
         
        }
        
        .navigationTitle(self.viewType == .Add ? "添加题目":"编辑题目")
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
    
    func saveTopic() {
        var topicModel = BTTopicEntity()
        topicModel.topicType = topicTypeModel.topicType
        topicModel.topicTitle = topicTitle
        topicModel.topicAnswer = topicAnswer
        
        if self.viewType == .Add {
            topicModel.topicID = UUID().uuidString
            BTWCDB.insertData(.topicEntity, objects: [topicModel]) { results in
                if results == true {
                    actionStr = "题目添加成功"
                    topicTitle = ""
                    topicAnswer = ""
                }else{
                    actionStr = "题目添加失败"
                }
                addActionSheet.toggle()
            }
        }else {
            topicModel.topicID = self.topicID
            BTWCDB.update(.topicEntity, on: [BTTopicEntity.Properties.topicID, BTTopicEntity.Properties.topicTitle, BTTopicEntity.Properties.topicAnswer, BTTopicEntity.Properties.topicType], object: topicModel, condition: BTTopicEntity.Properties.topicID == topicModel.topicID) { result in
                if result == true {
                    actionStr = "题目修改成功"
                    topicTitle = ""
                    topicAnswer = ""
                    isSaveSuccess = true
                    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "update"), object: nil)
                }else{
                    actionStr = "题目修改失败"
                }
                addActionSheet.toggle()
            }


        }
        

        
    }
    
    func canSubmit() -> Bool {
        guard topicTypeModel.topicType.count != 0,topicAnswer.count != 0, topicTitle.count != 0 else {
            return false
        }
        return true
    }

}

struct BTTextEditor: View {

    @Binding var TVtext:String
//
//    var textClosure:BTCommonClosure<String>?
    
    
    
    
    var body: some View {
        ZStack{
             TextEditor.init(text: $TVtext)
                .padding(.leading, 10)
                .font(.custom("Helvetica", size: 15))
                .foregroundColor(.black)
                .submitLabel(.done)
                .submitScope(true)

            
            if TVtext.isEmpty {
                HStack(){
                    VStack{
                        Text("请输入")
                            .font(.custom("Helvetica", size: 15))
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                        Spacer()
                    }
                    .padding(.top, 8)
                    Spacer()
                }
            }
        }
    }
}

struct TopicTypeSelectView: View {
    @State var typeSelect = false
    @State var topicName = "请选择题目类型"
    @Binding var topicType:String
    
    var body: some View {
        VStack{
            HStack{
                Label.init(
                    title: { Text(topicName) }, icon: {}
                )
                .padding(.leading, 15.0)
                Spacer()
            }
            HStack {
                BTTopicTypeMenu(tipicTypeModel:$topicType)
                .padding(.leading, 15.0)
                Spacer()
            }
        }
        
        
    }
    
    
    
}


struct AddTopicView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            AddTopicView()
        }
        
    }
}
