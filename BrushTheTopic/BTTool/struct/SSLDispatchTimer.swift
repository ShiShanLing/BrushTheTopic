//
//  SSLDispatchTimer.swift
//  TableViewTimer
//
//  Created by 石山岭 on 2021/9/7.
//

import Foundation

struct SSLDispatchTimer {
    
    static var dispatchSourceTimerDic = [String:DispatchSourceTimer]()
    
    /// 创建一个GCD的timer
    /// - Parameters:
    ///   - name: 倒计时唯一标识
    ///   - timeInterval: 多少时间循环一次
    ///   - queue: 队列
    ///   - repeats: 是否重复
    ///   - actionClosure: 回调
    /// - Returns:
    static func createDispatchTimer(name:String, timeInterval:Double, queue:DispatchQueue, repeats:Bool, actionClosure:@escaping () -> ()){
        var timer = dispatchSourceTimerDic[name]
        if timer == nil{
            timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
            timer?.resume()
            dispatchSourceTimerDic[name] = timer
        }
        timer?.schedule(deadline: .now(), repeating: timeInterval, leeway: .milliseconds(100))
        timer?.setEventHandler(handler: {
            actionClosure()
            if repeats == false {
                //销毁定时器
                if let timer = self.dispatchSourceTimerDic[name] {
                    self.dispatchSourceTimerDic.removeValue(forKey: name)
                    timer.cancel()
                }
            }
        })
    }
    /// 销毁指定定时器
    /// - Parameter name: 定时器唯一标识
    static func destoryDispatchTimer(name:String){
        if let timer = self.dispatchSourceTimerDic[name] {
            self.dispatchSourceTimerDic.removeValue(forKey: name)
            timer.cancel()
        }
    }
    
}
