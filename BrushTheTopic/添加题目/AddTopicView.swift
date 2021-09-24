//
//  AddTopicView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/15.
//

import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct AddTopicView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingDetail = false
    @State var topicTitle = ""
    @State var topicAnswer = ""
    var body: some View {
        NavigationView {
            ScrollView{
                TopicTypeSelectView()
                    .padding(.leading, 15.0)
                    .padding(.top, 25)
                
                Text("填写题目:\(topicTitle)")
                    .frame(width: SCREEN_WIDTH-60, height: 30, alignment: .leading)
                BTTextEditor(topicTitle: topicTitle) { text in
                    topicTitle = text
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(Color.yellow, lineWidth: 1)
                )
                .frame(width: SCREEN_WIDTH-60, height: 100, alignment: .leading)
                Text("填写答案:\(topicAnswer)")
                    .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                BTTextEditor(topicTitle: topicTitle) { text in
                    topicAnswer = text
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(Color.yellow, lineWidth: 1)
                )
                .frame(width: SCREEN_WIDTH-60, height: 100, alignment: .leading)
                
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            //这个要在navigation内部隐藏
            .navigationBarHidden(true)
        }
        
        .navigationTitle("添加题目")
        .foregroundColor(.blue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)//隐藏系统返回按钮
        .navigationBarItems(leading:
                                Button.init(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Label.init("返回首页", image: "BT_return")
                                })
                            
        )
   
    }
}

struct BTTextEditor: View {
    @State var title:String = ""
    
    @State var topicTitle = ""
    
    var textClosure:BTCommonClosure<String>?
    
    var body: some View {
        
        ZStack{
            
            TextEditor.init(text: $topicTitle)
                .padding(.leading, 10)
                .font(.custom("Helvetica", size: 15))
                .foregroundColor(.black)
                .onChange(of: topicTitle, perform: { newValue in
                    textClosure?(newValue)
                })
            
            if topicTitle.isEmpty {
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
                BTRightIconItem.init { model in
                    
                }
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
            BTTextEditor()
            TopicTypeSelectView()
        }
        
    }
}
