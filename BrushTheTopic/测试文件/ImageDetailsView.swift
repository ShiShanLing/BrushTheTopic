//
//  ImageDetailsView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/3.
//

import SwiftUI


struct ImageDetailsView: View {
    @State var progress = ImageInfo()
    var body: some View {
        List {
            ForEach(progress.entrys.indices, id: \.self){ pro in
                VStack {
                    HStack {
                        Text("imageName:")
                            .padding(.leading)
                        Spacer()
                        Text("\(progress.entrys[pro].imageName)")
                            .padding(.trailing)
                    }
                    .padding(.all, 2.0)
                    
                    HStack {
                        Text("imageSize:")
                            .padding(.leading)
                        Spacer()
                        Text("\(progress.entrys[pro].imageSize)")
                            .padding(.trailing)
                    }
                    .padding(.all, 2.0)
                }
            }
            
        }
        
    }
}

struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView()
    }
}
