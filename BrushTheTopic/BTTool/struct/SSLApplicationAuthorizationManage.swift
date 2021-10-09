//
//  SSLApplicationAuthorizationManage.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/10/8.
//

import Foundation

import AVFoundation
import UIKit
import Photos

struct SSLApplicationAuthorizationManage {
    
    enum OCPermissionEnum {
        //音频
        case audio
        //视频/相机
        case video
        //相机
        case camera
        //相册
        case photoLibrary
        //定位权限
        case location
        
        func getPermissionAlertTitle() -> String {
            switch self {
            case .audio:
                return "请去-> [设置 - 隐私 - 麦克风] 打开访问开关"
            case .video, .camera:
                return "请去-> [设置 - 隐私 - 相机] 打开访问开关"
            case .photoLibrary:
                return "请去-> [设置 - 隐私 - 相册] 打开访问开关"
            case .location:
                return "您的定位功能未打开,请去设置打开定位功能."
            }
        }
        
    }
    /// 请求应用权限
    /// - Parameters:
    ///   - permissionEnum: 应用类型
    ///   - authorizationStatus: 授权状态 只有可以访问时才会调用 authorizationStatus 不可访问状态在内部已经处理
    static func requestApplicationAuthorization(permissionEnum:OCPermissionEnum, authorizationStatus:@escaping BTCommonClosure<Bool>) {
        switch permissionEnum {
        case .audio:
            let state = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
            if  state == .denied {
                openApplicationSetting(permissionEnum: permissionEnum)
            }else if state == .notDetermined {
                AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                })
            }else{
                authorizationStatus(true)
            }
        case .camera, .video:
            let state = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if  state == .denied {
                openApplicationSetting(permissionEnum: permissionEnum)
            }else if state == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    
                }
            }else{
                authorizationStatus(true)
            }
        case .photoLibrary:
            let state = PHPhotoLibrary.authorizationStatus()
            if  state == .denied {
                openApplicationSetting(permissionEnum: permissionEnum)
            }else if state == .notDetermined {
                PHPhotoLibrary.requestAuthorization { status in
                    
                }
            }else{
                authorizationStatus(true)
            }
        case .location:
            
            let state = CLLocationManager.authorizationStatus()
            if state == .denied {
                openApplicationSetting(permissionEnum: permissionEnum)
            }else if state == .notDetermined || state == .restricted{
                let locationManager = CLLocationManager()
                locationManager.requestWhenInUseAuthorization()
            }else{
                authorizationStatus(true)
            }
        }
    }
    static func openApplicationSetting(permissionEnum:OCPermissionEnum) {
        if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
            let alertCon = UIAlertController.init(title: permissionEnum.getPermissionAlertTitle(), message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "知道了", style: .cancel, handler: nil)
            let okAction = UIAlertAction.init(title: "去设置", style: .default, handler: { (action) in
                UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: nil)
            })
            alertCon.addAction(cancelAction)
            alertCon.addAction(okAction)
            UIApplication.shared.windows.first?.rootViewController?.present(alertCon, animated: true, completion: nil)
        }
    }
    
}
