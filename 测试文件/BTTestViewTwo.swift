//
//  BTTestViewTwo.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/8.
//

import SwiftUI
import WebKit

struct BTTestViewTwo: View {
    @State var isActive = true
    @State private var shouldShowPurple = false

    
    @Environment(\.presentationMode) var presentationMode
    
    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }
    
    enum Topping: String, CaseIterable, Identifiable {
        case nuts
        case cookies
        case blueberries
        var id: String { self.rawValue }
    }
    
    enum AnswerWayEnum {
        //文字
        case text
        //录音
        case recording
        //测试
        case test
    }
    
    @State private var answerWay:AnswerWayEnum = .recording
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var pickerValue = 0.3
    @State private var sliderValue:Float = 0
    @State private var stepperValue:Int = 0
    @State private var linkValue:Bool = false
    
    var body: some View {
        //明天任务,找到label和button点击跳转界面的方法.
        VStack{
            
            ScrollView {
//                Picker(selection: $pickerValue, label: Text("Picker")) {
//                    Text("1").tag(0.3)
//                    Text("2").tag(0.6)
//                    Text("3").tag(0.9)
//                }
//                .padding(.all)
//                .pickerStyle(SegmentedPickerStyle())

                
                
                Picker(selection: $answerWay, label: Text("Picker")) {
                    Text("文字答题").tag(AnswerWayEnum.text)
                    Text("语音答题").tag(AnswerWayEnum.recording)
                    Text("3").tag(AnswerWayEnum.test)
                }
                .padding(.all)
                .pickerStyle(SegmentedPickerStyle())
                
                
                GroupBox.init {
                    Text("Content")
                    Text("Content2")
                }
                
                Label.init(
                    title: { Text("Label") },
                    icon: { Image(systemName: "") }
                )
                
                Link(destination: URL(string: "https://developer.apple.com/documentation/addressbookui")!) {
                    Text("测试数据")
                }
                
                NavigationLink(
                    destination: BTWebView(reqUrlStr: "https://www.baidu.com")){
                    Text("界面push")
                        .foregroundColor(.blue)
                }
                
                ProgressView(value: pickerValue)
                    .padding(.all)
                
                TextField(
                    "User name (email address)",
                    text: $username)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                SecureField(
                    "Password",
                    text: $password
                ) {
                    print("$password==\($password)\($username)")
                }
                .padding(.horizontal)
                .border(Color(UIColor.separator))
                
                Slider.init(value: $sliderValue, in: 0...1.0) { editorState in
                    print(editorState)
                }
                .padding(.horizontal)
                
//                Stepper(value: $stepperValue, in: 0...10) {
//                    Text("商品数量\(stepperValue)")
//                }
//                .padding(.all)
                //            ScrollView.init(.vertical, showsIndicators: true, content: {
                //            })
            }

            
        }
    }
    
    
}

struct BTTestViewTwo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            BTTestViewTwo()
        }
    }
}

/*
 List {
 NavigationLink(
 destination: DestinationPageView(color: .purple),
 isActive: $shouldShowPurple
 ) {
 Text("Purple Page")
 }
 NavigationLink(
 destination: DestinationPageView(color: .red)
 ) {
 Text("Pink Page")
 }
 NavigationLink(
 destination: DestinationPageView(color: .orange)
 ) {
 Text("Orange Page")
 }
 }
 let data =
 FileItem(name: "users", children:
 [FileItem(name: "user1234", children:
 [FileItem(name: "Photos", children:
 [FileItem(name: "photo001.jpg"),
 FileItem(name: "photo002.jpg")]),
 FileItem(name: "Movies", children:
 [FileItem(name: "movie001.mp4")]),
 FileItem(name: "Documents", children: [])
 ]),
 FileItem(name: "newuser", children:
 [FileItem(name: "Documents", children: [])
 ])
 ])
 
 OutlineGroup(data, children: \.children) { item in
 Text("\(item.description)")
 }
 .padding(.all)
 */
