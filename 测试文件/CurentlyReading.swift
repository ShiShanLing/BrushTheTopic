//
//  CurentlyReading.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/3.
//

import Foundation

class CurentlyImageInfo: ObservableObject {
    
    @Published var progress = ImageInfo()
    
}

struct ImageInfo {
    struct Entry:Identifiable {
        var id = ""
        var imageName = ""
        var imageSize:Double = 0
    }
    var entrys:[Entry] = []
}
