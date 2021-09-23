//
//  BTPublicPropertyAndFunc.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/15.
//
///全局的对象和方法会放到这里里面
import Foundation
import UIKit

//MARK: 屏幕的尺寸
public let SCREEN_HEIGHT =  UIScreen.main.bounds.height
public let SCREEN_WIDTH  =  UIScreen.main.bounds.width
public let KEY_SCREEN_SIZE = UIScreen.main.bounds.size

//百分比适配屏幕方法-(iPad除外)
func kFit(_ size:CGFloat) -> CGFloat {
    let deviceType = UIDevice.current.model
    if (deviceType == "iPhone") || (deviceType == "iPod touch") {
        return size*(SCREEN_WIDTH)/375.0
    } else  {
        return size
    }
    
}

typealias BTCommonClosure<T> = (T) -> ()

///适配ipad
func kiPadFit(_ size:CGFloat) -> CGFloat {
    return  size*(SCREEN_WIDTH)/375.0
}
//传进来float 返回 UIFont
func kFont(_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}
//UIApplication.shared.

///导航条高度
public var kStatusBarAndNavigationBarHeight:CGFloat = isIPad() ? UIApplication.shared.statusBarFrame.size.height + 50.0:UIApplication.shared.statusBarFrame.size.height + 44.0
///X系列手机 导航条额外高度
public let kNavigationBarXExtraHeight:CGFloat = isIPhoneX() ? 24.0:0.0
///底部安全区域高度
public let kTabbarSafeBottomMargin:CGFloat = isIPhoneX() ? 34.0:0.0
///tabbar 的高度
public let kTabbarHeight:CGFloat  = isIPhoneX() ? 83 : 49

///判断是不是X类手机
func isIPhoneX() -> Bool {
    
    switch UIDevice.current.modelName {
    case "iPhone X":
        return true
    case "iPhone XR":
        return true
    case "iPhone XS":
        return true
    case "iPhone XS Max":
        return true
    case "iPhone 11":
        return true
    case "iPhone 11 Pro":
        return true
    case "iPhone 11 Pro Max":
        return true
    case "iPhone 12":
        return true
    case "iPhone 12 Pro":
        return true
    case "iPhone 12 Pro Max":
        return true
    case "iPhone 12 mini":
        return true

    default:
        return false
    }
}
///判断是否是ipad
func isIPad () -> Bool {
    if  UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
        return true
    }else {
        return false
    }
}
