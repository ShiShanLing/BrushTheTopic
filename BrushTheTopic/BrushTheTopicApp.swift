//
//  BrushTheTopicApp.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/8/30.
//

import SwiftUI

@main
struct BrushTheTopicApp: App {
    
    
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            BTHomeVC()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }.onChange(of: scenePhase) { newValue in
            switch newValue {
            case .active:
                
                let _ = BTFileManage.fileExists(atPath: wcdbCacheTablePath)
                
                let _ = BTFileManage.fileExists(atPath: recordingCachePath)
                break
            case .inactive:
                break
            case .background:
                break
          @unknown default:
                break
            }
        }
        
        
        
    }
 
}

