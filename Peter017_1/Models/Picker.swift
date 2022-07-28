//
//  Picker.swift
//  Peter017_1
//
//  Created by DONG SHENG on 2022/7/27.
//

import SwiftUI
import AVFoundation

enum Picker{
    enum Source: String{
        case library, camera
    }
    
    enum PickerError: Error,LocalizedError{
        case unavailable    // 不可用
        case restricted     // 受限制
        case denied         // 拒絕
        
        var errorDescription: String?{
            switch self {
            case .unavailable:
                return NSLocalizedString("There is no available camera on this device. 此設備上沒有可用鏡頭 因此無法使用" ,comment: "")
            case .restricted:
                return NSLocalizedString("You are not allowed access media capture devices. 存取Media 受限制無法使用" ,comment: "")
            case .denied:
                return NSLocalizedString("You have explicitly denied permission for media cature. 您沒有授權鏡頭權限 因此無法使用" ,comment: "")
            }
        }
    }
    
    // 檢查
    static func checkPermissions() throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus{
            case .denied:
                throw PickerError.denied
            case .restricted:
                throw PickerError.restricted
            default:
                break
            }
        } else {
            throw PickerError.unavailable
        }
    }
    
    // 定義
    struct CameraErrorType{
        let error: Picker.PickerError
        var message: String{
            error.localizedDescription
        }
        let button = Button("OK",role: .cancel) { }
    }
}
