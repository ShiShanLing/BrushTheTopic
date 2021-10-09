//
//  BTAudioPlayer.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/30.
//

import Foundation
import AVFoundation
import AVFAudio

var audioPlayer = BTAudioPlayer()

class BTAudioPlayer {
    var audioPlayer:AVAudioPlayer?
    
    func createPlayer(url:URL, closure:@escaping BTCommonClosure<(duration:Float, currentTime:Float)>) {
        let session: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback)
            try session.setActive(true)
        } catch {
            print(error)
        }

        do {
             audioPlayer = try AVAudioPlayer.init(contentsOf: url)
        } catch  {
            print("播放器初始化失败")
        }
        if audioPlayer?.prepareToPlay() == true {
            let duration:Float = Float(round(audioPlayer?.duration ?? 0))
            closure((duration, 0))
            print("开始播放")
        }else {
            print("播放失败")
        }
    }
    
    //MARK:播放音频
    func playRecording(closure:@escaping BTCommonClosure<(duration:Float, currentTime:Float)>) {
        if audioPlayer?.prepareToPlay() == true {
            print("开始播放")
            audioPlayer?.play()
            ///总时长
            let duration:Float = Float(round(audioPlayer?.duration ?? 0))
            
            SSLDispatchTimer.createDispatchTimer(name: "audioPlayer", timeInterval: 1, queue: DispatchQueue.global(), repeats: true) {
                let currentTime = Float(round(self.audioPlayer?.currentTime ?? 0))
                closure((duration, currentTime))
                //播放结束销毁定时器
                if currentTime == duration {
                    SSLDispatchTimer.destoryDispatchTimer(name: "audioPlayer")
                }
            }
            
        }else {
            print("audioPlayer.prepareToPlay()==false")
        }
         

    }
    
}
