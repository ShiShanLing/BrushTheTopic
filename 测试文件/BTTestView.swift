//
//  BTTestView.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/8.
//

import SwiftUI

struct BTTestView: View {
    @State var date = Date()
    
    var closure:((Date) -> ())? = nil

    struct ToggleStates {
        var oneIsOn: Bool = false
        var twoIsOn: Bool = true
    }
   @State private var toggleStates = ToggleStates()
   @State private var topExpanded: Bool = true
    
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        
        VStack {
            
            //MARK:btn创建方式
            Button("搜索") {
                print($date)
            }
            
            Button.init(action: {

            }, label: {
                Label.init("搜索开始", image:"OC_city_search_icon_004")
            })
            
            DisclosureGroup.init(
                content: {
                    Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                    Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                },
                label: {
                    Text("Label1")
                }
            )
            .frame(width: 280, height: 50, alignment: .center)
     
            
            DatePicker(
                "Start Date",
                selection: $date,//这个值会自动变化
                in:dateRange,//设置一个时间选择区间
                displayedComponents: [.date]
            )
            .frame(width: 280, height: 50, alignment: .center)

        }
        
    }
    func selectHearts() {
        // Act on hearts selection.
    }
    func selectClubs() { }
    func selectSpades() {  }
    func selectDiamonds() {  }
}

struct BTTestView_Previews: PreviewProvider {
    static var previews: some View {
        BTTestView(date: Date()) { _ in
            
        }
    }
}
