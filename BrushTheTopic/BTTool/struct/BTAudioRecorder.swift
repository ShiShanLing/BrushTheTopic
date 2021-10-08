//
//  BTAudioRecorder.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/29.
//

import Foundation
import AVFoundation

class BTAudioRecorder {
    ///录音计时器
    var recordTimer:Timer?
    var recorder:AVAudioRecorder?
    var audioPlayer:AVAudioPlayer?
    //时间
    var recordSecond = 0
    
    var recordEnd:BTCommonClosure<String>?
    
    var recordPath = ""
    
    var fileName = ""
    
    var recordSecondClosure:BTCommonClosure<Int>?
    
    ///开始录音
    /*
     300 10
     每 首30  总100 平1
     没 1.5 150 总1500
     1500
     
    */
    func startRecording(recordingName:String, closure: BTCommonClosure<Int>?) {
        fileName = recordingName
        recordSecondClosure = closure
        let configDic = [
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
        // 采样率
            AVSampleRateKey: NSNumber(value: 11025.0),
        // 通道数
            AVNumberOfChannelsKey: NSNumber(value: 2),
        // 录音质量
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)
        ]
        let recordingPath = URL(fileURLWithPath: recordingCachePath).appendingPathComponent("\(recordingName).wav")
        BTFileManage.fileExists(atPath: recordingCachePath)
        let recordingUrl = URL(string: recordingPath.path)!
        
        self.recordPath = recordingPath.path
        
        do {
            self.recorder = try AVAudioRecorder.init(url: recordingUrl, settings: configDic)
        } catch let error {
            print("recorder_error 录音创建失败==\(error)")
        }
        if recorder?.prepareToRecord() == true {
            self.startRecording()
        }else {
            print("录音启动失败")
        }
    }
    
    func startRecording() {
        recorder?.record()
        self.recordSecond = 0
        recordTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            self.recordSecond += 1
            DispatchQueue.main.async {
                self.recordSecondClosure?(self.recordSecond)
            }
        }
        recordTimer?.fire()
    }
    ///继续录音
    func continueRecording() {
        recorder?.record()
        recordTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            self.recordSecond += 1
            DispatchQueue.main.async {
                self.recordSecondClosure?(self.recordSecond)
            }
        }
        recordTimer?.fire()
    }
    ///暂停录音
    func pauseRecording() {
        recorder?.pause()
        recordTimer?.invalidate()
        recordTimer = nil
    }
    ///停止录音
    func stopRecording(closure:BTCommonClosure<String>) {
        recorder?.stop()
        recorder = nil
        recordTimer?.invalidate()
        recordTimer = nil
        closure(self.recordPath)
    }
    
    

}
