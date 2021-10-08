//
//  BTWebView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/8.
//

import SwiftUI


struct BTWebView:View {
    @State var reqUrlStr = "https://www.baidu.com"
    var body: some View {
        VStack{
            TBWKWebView(requestStr: reqUrlStr)
        }
        .navigationTitle("webview")
        
    }
    
    
    
}

struct BTWebView_Previews: PreviewProvider {
    static var previews: some View {
        BTWebView()
    }
}
