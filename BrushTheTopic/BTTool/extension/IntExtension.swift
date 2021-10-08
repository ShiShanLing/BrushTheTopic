//
//  IntExtension.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/30.
//

import Foundation

extension Int {
    ///转换为tiemr 02:30
     func toTime() -> String {
        if self <= 0 {
            return ""
        }
        let hour = self / 3600//小时
        let min = (self % 3600) / 60//分钟
        let second = self % 60 //秒
        
        var timeStr = ""

        if hour != 0 {
            if hour >= 10 {
                timeStr += "\(hour):"
            }else{
                timeStr += "0\(hour):"
            }
        }
        if min >= 10 {
            timeStr += "\(min):"
        }else{
            timeStr += "0\(min):"
        }
        if second >= 10 {
            timeStr += "\(second)"
        }else{
            timeStr += "0\(second)"
        }
        return timeStr
        
    }
}


