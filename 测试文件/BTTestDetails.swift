//
//  BTTestDetails.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/8/31.
//

import SwiftUI

struct BTTestDetails: View {
    var imageName:String
    @State var zoomed = false
    var body: some View {
        
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill:.fit)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
            Spacer()
            
            if imageName == "test" && !zoomed{
                HStack {
                    Spacer()
                    Label("Spicy", systemImage:"flame.fill")
                    Spacer()
                }
                .padding(.all)
                .font(Font.headline.smallCaps())
                .background(Color.red)
                .foregroundColor(Color.yellow)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("测试标题")
        .background(Color.gray)
        .edgesIgnoringSafeArea(.bottom)
        
        
        
    }
}

struct BTTestDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView{
                    BTTestDetails(imageName: "test")
            }
            NavigationView{
                BTTestDetails(imageName: "test3")
            }
        }
    }
}
