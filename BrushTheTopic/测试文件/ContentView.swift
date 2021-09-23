//
//  ContentView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/8/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var dataArray:[String] = []
    
    var body: some View {
        NavigationView{
            List{
                ForEach(dataArray.indices, id:\.self) { str in
                    BTTestCell(data: dataArray[str])
                }
                .onDelete(perform: { indexSet in
                    withAnimation(.easeOut) {
                        dataArray.remove(atOffsets: indexSet)
                    }
                })
                .onMove(perform: { indices, newOffset in
                    dataArray.move(fromOffsets: indices, toOffset: newOffset)
                })
                HStack {
                    Spacer()
                    Text("\(dataArray.count)")
                    Spacer()
                }
            }
            .navigationTitle("SSl")
            .toolbar(content: {
                
                ToolbarItemGroup {
                    
                    
                    EditButton()
                    
                    
                }
            })
//
//ipad里面的占位符
//            Text("请选择一张图片")
//                .font(.largeTitle)
        }
    }
    
    func makeAddImage() {
        dataArray.append("test4")
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(dataArray: ["test", "test2", "test3"])
            ContentView(dataArray: ["test", "test2", "test3"])
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            ContentView(dataArray: ["test", "test2", "test3"])
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

struct BTTestCell: View {
    var data:String
    var body: some View {
        NavigationLink(destination:BTTestDetails(imageName: data)){
            VStack(alignment: .leading) {
                HStack {
                    Text("Hello, world!\(data)")
                        .font(.title)
                        .foregroundColor(.red)
                }
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }
            .padding()
        }
    }
}
