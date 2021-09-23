//
//  TBWKWebView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/8.
//

import SwiftUI
import WebKit

struct TBWKWebView:View, UIViewRepresentable {
    var requestStr = ""
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context:Context) {
        guard let reqUrl = URL(string: requestStr) else {
            return
        }
        uiView.backgroundColor = .white
        uiView.load(URLRequest(url:reqUrl))
    }
}

struct TBWKWebView_Previews: PreviewProvider {
    static var previews: some View {
        TBWKWebView()
    }
}
