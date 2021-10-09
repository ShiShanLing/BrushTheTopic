//
//  BTAudioRecorder.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/29.
//

import Foundation
import AVFoundation

var audioRecorder = BTAudioRecorder()

class BTAudioRecorder:NSObject, AVAudioRecorderDelegate {
    ///录音计时器
    var recordTimer:Timer?
    var recorder:AVAudioRecorder?
    var audioPlayer:AVAudioPlayer?
    //时间
    var recordSecond = 0
    
    var recordPath = "" {
        willSet {
            print("newValue==\(newValue)")
        }
    }
    
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
        let recordSettings = [ AVFormatIDKey : kAudioFormatLinearPCM,
                    AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue,
                       AVNumberOfChannelsKey : 2,
                             AVSampleRateKey : 44100 ] as [String : Any]
        
        let _ = BTFileManage.fileExists(atPath: recordingCachePath)
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
        
        
        
        self.recordPath = recordingPath.path
        do {
            
            self.recorder = try AVAudioRecorder.init(url: recordingPath, settings: recordSettings)
            self.recorder?.delegate = self
        } catch let error {
            print("recorder_error 录音创建失败==\(error)")
        }
        
        SSLApplicationAuthorizationManage.requestApplicationAuthorization(permissionEnum: .audio) { _ in
            if self.recorder?.prepareToRecord() == true {
                self.startRecording()
            }else {
                print("录音启动失败")
            }
        }
     
    }
    
    let RecordingTimer = "RecordingTimer"

    
    func startRecording() {
        recorder?.record()
        self.recordSecond = 0
        SSLDispatchTimer.createDispatchTimer(name: RecordingTimer, timeInterval: 1, queue: DispatchQueue.global(), repeats: true) {
            self.recordSecond += 1
            DispatchQueue.main.async {
                self.recordSecondClosure?(self.recordSecond)
            }
            print("startRecording==\(self.recordSecond)")
        }
    }
    ///继续录音
    func continueRecording() {
        recorder?.record()
        SSLDispatchTimer.continueDispatchTimer(name: RecordingTimer)
        print("continueRecording===\(self.recordPath)")
    }
    ///暂停录音
    func pauseRecording() {
        recorder?.pause()
        SSLDispatchTimer.pauseDispatchTimer(name: RecordingTimer)
        print("pauseRecording===\(self.recordPath)")
    }
    ///停止录音
    func stopRecording(closure:BTCommonClosure<String>) {
        recorder?.stop()
        recorder = nil
        print("stopRecording===\(self.recordPath)")
        SSLDispatchTimer.destoryDispatchTimer(name: RecordingTimer)
        recordSecondClosure = nil
        closure(self.recordPath)
    }
    
    

}
