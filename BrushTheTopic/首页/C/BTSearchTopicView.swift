//
//  BTSearchTopicView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/16.
//

import SwiftUI

struct BTSearchTopicView: View {

    
    @State var searchTest = ""
    @Environment(\.presentationMode) var presentationMode
    @State var searchResultsArray:[BTTopicEntity] = BTTopicApi.importLocalData()
    var body: some View {
        VStack{
            HStack{
                Spacer(minLength: 20)
                TextField("输入关键字搜索", text: $searchTest)
                    .onChange(of: searchTest, perform: { newValue in
                        
                    })
                    
                    .padding(.vertical, 5.0)
                    .padding([.leading, .trailing], 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .frame(height: 44, alignment: .center)
                
                Spacer(minLength: 20)
                Button.init("取消") {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 44, alignment: .center)
                Spacer(minLength: 20)
            }
            
            if searchResultsArray.count != 0 {
                HStack{
                    Text("搜索结果")
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    Spacer()
                }
                   
            }
            
            List.init {
                ForEach.init(searchResultsArray, id: \.self) { data in
                    BTSearchTopicCell(model: data)
                        
                }.onDelete(perform: { indexSet in
                    withAnimation(.easeOut) {
                        searchResultsArray.remove(atOffsets: indexSet)
                    }
                })
                
            }
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func getData(){
        self.searchResultsArray = BTTopicApi.importLocalData()
    }
    
}

struct BTSearchTopicCell: View {
    
    var model = BTTopicEntity()
    @State var isUnfoldAnswer = false
    var body: some View {
        //标题 答案 次数
        VStack{
            //题目类型
            HStack {
                Text(model.topicType)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .font(.title3)
                Spacer()
                VStack{
                    Text("学习过\(model.LearnNum)次")
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .foregroundColor(.yellow)
                        .fixedSize()
                }
            }
            
            HStack {
                Text(model.topicTitle)
                    .font(.title3)
                Spacer()
            }
            
            HStack{
                Text(model.topicAnswer)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 0)
                    .padding(.top, 15.0)
                    .lineLimit(isUnfoldAnswer == true ? Int.max : 2)
            
                Spacer()
            }
            HStack {
                Spacer()
                Button.init(action: {
                    isUnfoldAnswer.toggle()
                }, label: {
                    Image(isUnfoldAnswer == false ? "BT_addTopic_XL" : "BT_addTopic_SL")
                })
                .frame(width: 60, height: 30, alignment: .center)
            }
        }
    }

    
}

struct BTSearchTopicView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BTSearchTopicView.init()
        }
        
    }
}
