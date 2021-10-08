//
//  BTTestViewFour.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/10.
//

import SwiftUI

struct BTTestViewFour: View {
    let transform = CATransform3DMakeRotation(
        -30 * (.pi / 180), 0.0, 0.0, 1.0)
    let transform1 = CGAffineTransform(rotationAngle: -30 * (.pi / 180))

    @State private var isFlipped = true
    @Namespace private var animation
    var body: some View {
        VStack {

            if isFlipped {
                Label.init(
                    title: { Text("Label").foregroundColor(.white) },
                    icon: { Image(systemName: "42.circle").foregroundColor(.white) }
                )
                
                .frame(width: 300, height: 50, alignment: .center)
//                .projectionEffect(.init(transform))
//                .rotationEffect(.zero)
                //view背景颜色
                .background(Color.red)
                .opacity(1)
                //亮度
    //            .brightness(0.30)
                //灰度
//                .grayscale(0.50)
                //切割
    //            .clipped()
                //不知道
    //            .colorMultiply(.gray)
                //圆角
                .cornerRadius(25)
//                //边框
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                        .stroke(Color.yellow, lineWidth: 1)
                )
//                .matchedGeometryEffect(id: "label", in: animation)
                
                .shadow(color: .black, radius: 10, x: 0, y: 0)
//                .scaleEffect(1)
                .padding(.all, 22.0)
                    

                Color.red.frame(width: 300, height: 100, alignment: .center)
    //                .rotationEffect(.degrees(45))                .
    //                .padding(5)
                    //暂时未知
                    .blendMode(.luminosity)
                    //模糊度
    //                .blur(radius: 30.0)
                    .border(Color.yellow, width: 1)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .matchedGeometryEffect(id: "Color", in: animation)
            }else {
                
                    
                Color.red.frame(width: 300, height: 100, alignment: .center)
    //                .rotationEffect(.degrees(45))                .
    //                .padding(5)
                    //暂时未知
                    .blendMode(.luminosity)
                    //模糊度
    //                .blur(radius: 30.0)
                    .border(Color.yellow, width: 1)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                    .matchedGeometryEffect(id: "Color", in: animation)
                    
                
                
                Label.init(
                    title: { Text("Label") },
                    icon: { Image(systemName: "42.circle") }
                        
                )
                .frame(width: 300, height: 50, alignment: .center)
                
                //view背景颜色
                .background(Color.red)
                //亮度
    //            .brightness(0.30)
                //灰度
    //            .grayscale(0.50)
                //切割
    //            .clipped()
                //不知道
    //            .colorMultiply(.gray)
                //圆角
                .cornerRadius(25)
                //边框
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                        .stroke(Color.yellow, lineWidth: 1)
                )
                .matchedGeometryEffect(id: "label", in: animation)
                
            }
           

                
        }
        .preferredColorScheme(.dark)
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
        
        //不知道作用
        .accentColor(.yellow)
        //不知道作用
        .drawingGroup()
        
    }
}

struct BTTestViewFour_Previews: PreviewProvider {
    static var previews: some View {
        BTTestViewFour()
    }
}
