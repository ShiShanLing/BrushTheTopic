//
//  BTTestViewThree.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/9.
//

import SwiftUI

struct BTTestViewThree: View {
    @Namespace var topID
    @Namespace var bottomID
    
    @State var inputStr = "开始数据"
    var rows: [GridItem] =
            Array(repeating: .init(.fixed(20)), count: 3)
    
    var  tempDate = Date()
    
    
    @State private var showActionSheet = false
    @State private var showPopover = false
    @State private var showSheet = false
    @State private var fontSize = 0
    @State private var italic = false
    @State private var sliderValue:Float = 0
    var body: some View {

        VStack{
            
            Menu {
                Button("Duplicate"){
                    showSheet = true
                }
                Button("Rename"){
                    showPopover = true
                }
                Button("Delete…"){
                    showActionSheet = true
                }
                Menu("Copy") {
                    Button("Copy"){
                        
                    }
                    Button("Copy Formatted"){
                        
                    }
                    Button("Copy Library Path"){
                        
                    }
                }
            } label: {
                Label("PDF", systemImage: "doc.fill")
            }
            
            TextEditor(text: $inputStr)
                .frame(width: 200, height: 100, alignment: .center)
                .border(Color.gray)
                .cornerRadius(3)
                .toolbar {
                    ToolbarItemGroup {
                        Slider.init(value: $sliderValue, in: 0...20.0) { editorState in
                            print("Font Size (\(sliderValue))")
                        }
                        .frame(width: 150)
                        Toggle(isOn: $italic) {
                            Image(systemName: "italic")
                        }
                        
                    }
                }
         }

        .popover(isPresented: $showPopover, attachmentAnchor: PopoverAttachmentAnchor.point(UnitPoint.init(x: 30, y: 100)), arrowEdge: .bottom, content: {
            BTTestView(date: tempDate, closure: { tempDate in
                
            })
        })
        .sheet(isPresented: $showSheet, onDismiss: dismiss, content: {
            VStack{
                Text("112312312")
                Text("112312312")
                Text("112312312")
            }
        })
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet.init(title: Text("温馨提示"),
                             message: Text("开始拍照啦!"),
                             buttons: [
                                .cancel(),
                                .destructive(Text("拍照"), action: {

                                }),
                                .destructive(Text("相册"), action: {

                                }),
                                .default(Text("本地文档"), action: {

                                })
                             ])
        })

    }
    func testFunc() {
    
    }
    
    func dismiss() {
        
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

struct BTTestViewThree_Previews: PreviewProvider {
    static var previews: some View {
        BTTestViewThree()
    }
}
