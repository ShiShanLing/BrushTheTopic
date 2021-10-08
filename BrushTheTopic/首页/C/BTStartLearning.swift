//
//  BTStartLearning.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/29.
//

import SwiftUI
                    
/*
 一个全局的当前进行中数组
 一个全局的进行到第几题的下标
 场景:
                     1.按顺序全部学完了(需要加字段 今天是否学过-()).
                            / \
                         /       \
                     有不会的   没有不会的(结束)
                    /       \
            吧不会的在来一遍
                     
 */
struct BTStartLearning: View {
//    @State var topicModel:BTTopicEntity = BTWCDB.queryEntityTable(.topicEntity)[0]
    
    enum AnswerWayEnum {
        //文字
        case text
        //录音
        case recording
        //测试
        case test
    }
    @Environment(\.presentationMode) var presentationMode
    
    @State var answerWay:AnswerWayEnum = .recording
    
    @State var topicAnswer = ""
    
    var body: some View {
        VStack{
          

            ScrollView{
                Text("什么是runLoop？他可以用来做什么？项目中需要注意的地方。")
                    .padding(.horizontal, 15.0)
                
                Spacer(minLength: 30)
                Text("你第N次遇到这个问题")
                    .font(Font.init(UIFont.systemFont(ofSize: 15)))
                    .foregroundColor(.gray)
                
                Picker(selection: $answerWay, label: Text("Picker")) {
                    Text("文字答题").tag(AnswerWayEnum.text)
                    Text("语音答题").tag(AnswerWayEnum.recording)
                }
                
                .padding(.all)
                .pickerStyle(SegmentedPickerStyle())
                
                if answerWay == .text {
                    Spacer(minLength: 20)
                    BTTextEditor(TVtext: $topicAnswer)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .stroke(Color.yellow, lineWidth: 1)
                        )
                        .frame(width: SCREEN_WIDTH-60, height: 150, alignment: .leading)
                }else {
                    Spacer(minLength: 20)
                    BTRecordingView()
                        .frame(width: SCREEN_WIDTH-60, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .stroke(Color.yellow, lineWidth: 1)
                        )
                }
                Spacer(minLength: 30)
                Text("答题完毕")
                    .frame(width: 100, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                Spacer(minLength: 100)
                Text("忘记了?查看答案")
                    .frame(width: 200, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
                
            }
        }

        
    }
}

struct BTRecordingView: View {
    
    enum AudioRecorderState {
        ///待机状态
        case standby
        ///正在录音
        case working
        ///暂停录音
        case pause
        ///录音结束
        case end
    }

    @State var audioRecorderState:AudioRecorderState = .standby
    
    @State var totalTimer:Int = 0
    
    @State var palyTimer:Int = 0
    ///录音时间
    @State private var recordSecond = 100
    ///录音地址
    @State private var recordingPath = ""
    ///重新开始录制提示框
    @State private var againRecorderAlert = false
    
    
    var topicModel = BTTopicEntity()
    
    var audioRecorder = BTAudioRecorder()

    var audioPlayer = BTAudioPlayer()
    
    var body: some View {
        VStack {
            HStack{
                Spacer(minLength: 10)
                
                Button.init {
                    switch audioRecorderState {
                    case .standby:
                        audioRecorder.startRecording(recordingName: "\(topicModel.topicID)_\(Date().dateToString("yyyyMMddHHmmss"))") { recordSecond in
                            self.recordSecond = recordSecond
                        }
                        audioRecorderState = .working
                    case .working://如果正在录音点击说明要暂停
                        audioRecorder.pauseRecording()
                        audioRecorderState = .pause
                    case .pause:
                        audioRecorder.continueRecording()
                        audioRecorderState = .working
                    case .end:
                        againRecorderAlert = true
                    }
                        
                } label: {
                    /*
                     如果未开始 开始录音 
                     如果正在录音 开始录音(00:02)
                     如果录音结束 重新录制
                     重新录制 开始录音(00:02)
                     */
                    if audioRecorderState == .standby {
                        Text("开始录音")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }else if audioRecorderState == .working {
                        Text("暂停(\(recordSecond.toTime()))")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }else if audioRecorderState == .pause {
                        Text("继续(\(recordSecond.toTime()))")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }else if audioRecorderState == .end{
                        Text("重新录制")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 30)
                .padding(.horizontal)
                .background(kColor(148, 156, 163))
                .cornerRadius(8)
                .alert(isPresented: $againRecorderAlert){
                    
                    Alert.init(title: Text("温馨提示"),
                               message: Text("重新录音会清空上一段录音,确认吗?"),
                               primaryButton: .destructive(Text("确认"), action: {
                        recordSecond = 0
                        audioRecorderState = .working
                        recordingPath = ""
                        audioRecorder.startRecording(recordingName: "\(topicModel.topicID)_\(Date().dateToString("yyyyMMddHHmmss"))") { recordSecond in
                            self.recordSecond = recordSecond
                        }
                    }), secondaryButton: .cancel(Text("取消")))
                }
                
                Spacer()
                
                Button.init {
                    audioRecorder.stopRecording { filePath in
                        print("filePath==\(filePath)")
                        recordingPath = filePath
                        audioPlayer.createPlayer(url: URL(fileURLWithPath: filePath)) { (duration: Int, currentTime: Int) in
                            totalTimer = duration
                            palyTimer = currentTime
                        }
                    }
                    audioRecorderState = .end
                } label: {
                    Text("结束录音")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                .frame(height: 30)
                .padding(.horizontal)
                .background(kColor(148, 156, 163))
                .cornerRadius(8)
                Spacer()
            }
            .padding(.top, 10.0)
            if recordingPath.count != 0 {
                Spacer()
                BTRecordingPalyView(totalTimer: $totalTimer, palyTimer: $palyTimer)
            }
            Spacer()
            
        }
        
        
    
    }
}

struct BTRecordingPalyView: View {
    //总时长
    @Binding var totalTimer:Int
    //当前播放的时长
    @Binding var palyTimer:Int
    
    @State var testTime:Int = 40
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .padding(.horizontal, 10.0)
                .foregroundColor(kColor(226, 226, 226))
                .frame(height: 40)
                
            HStack {
                Button.init {
                    
                } label: {
                    //BT_paly  BT_pause
                    Image("BT_paly")
                }
                .frame(width: 36, height: 36)
                .background(Color.white)
                .cornerRadius(18)
                .padding(.leading, 10)
                Spacer(minLength: 10)
                Text("\(palyTimer.toTime()) / \(totalTimer.toTime())")
                    .foregroundColor(.black)
                    .font(Font.init(UIFont.systemFont(ofSize: 13)))
                Spacer()
    
                Slider(value: $testTime, in: 0...100) { _ in
                    
                }

                
                Image("BT_paly_volume")
                    .padding(.trailing, 10)
                Spacer()
            }
            .padding(.horizontal, 10.0)
                
        }
    }
}


struct BTStartLearning_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            BTStartLearning()
        }
    }
}
