//
//  UIApplicationExtension.swift
//  BrushTheTopic
//
//  Created by 石山岭 on 2021/9/29.
//

import Foundation
import UIKit

extension UIApplication:UIGestureRecognizerDelegate {

    func addTapGestureRecognizer() {
          guard let window = windows.first else { return }
          let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
          tapGesture.cancelsTouchesInView = false
          tapGesture.delegate = self
          tapGesture.name = "MyTapGesture"
          window.addGestureRecognizer(tapGesture)
      }
}
