//
//  CircleImage.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/8/30.
//

import SwiftUI

struct CircleImage: View {
   @State var imageInfo = ImageInfo()
    
    var body: some View {
        
        NavigationView{
            VStack {
                Image("test")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4.0))
                    .shadow(radius: 7)
                
                Spacer()
                ImageDetailsView(progress: addImageData())
            }

        }
        .navigationTitle("图片详情")
     
    }
    
    func addImageData() -> ImageInfo {
        var imageInfo = ImageInfo()
        var Entrys = [ImageInfo.Entry]()
        Entrys.append(ImageInfo.Entry.init(id: "111", imageName: "111", imageSize: 111))
        Entrys.append(ImageInfo.Entry.init(id: "222", imageName: "222", imageSize: 222))
        imageInfo.entrys = Entrys
        return imageInfo
    }
    
}

struct CircleImage_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleImage()
        
    
    }
}
