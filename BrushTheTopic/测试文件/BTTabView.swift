//
//  BTTabView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/9.
//

import SwiftUI

struct BTTabView: View {
    var body: some View {
        TabView.init {

            BTHomeVC().tabItem {
                Label("首页", systemImage: "Add")
            }.tag(1)
        }
       
    }
}

struct BTTabView_Previews: PreviewProvider {
    static var previews: some View {
        BTTabView()
    }
}
