//
//  GBKit.swift
//  New
//
//  Created by 张泉 on 16/6/29.
//  Copyright © 2016年 Tuofeng. All rights reserved.
//

import UIKit
import Foundation
import Photos
import AVFoundation

class GBKit: NSObject {

    /**
     设置一个文本中所有指定文本高亮,通过正则查找
     
     - parameter allText:         <#allText description#>
     - parameter specifiedString: <#specifiedString description#>
     - parameter textColor:       <#textColor description#>
     */
    class func setSpecifiedText(allStr allStr:String, specifiedStr:String, textColor:UIColor) ->NSMutableAttributedString {
        
        let mutableStr = NSMutableAttributedString(string: String(allStr))
        let regular = try! NSRegularExpression(pattern: specifiedStr, options:.CaseInsensitive)
        let results = regular.matchesInString(allStr, options: .ReportProgress , range: NSMakeRange(0, allStr.characters.count))
        
        for result in results {
            mutableStr.addAttributes([NSForegroundColorAttributeName:UIColor.redColor()], range: result.range)
        }
        return mutableStr
    }
    
    /// 获取Document目录
    class func loadDocument(documentName documentName:String) ->String{
        
        let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                                          .UserDomainMask, true)[0]
        let filePath = docPath.stringByAppendingString("/\(documentName)/")
        let fileManager = NSFileManager.defaultManager()
        try! fileManager.createDirectoryAtPath(filePath, withIntermediateDirectories: true, attributes: nil)
        return filePath
    }
    
    /**
     正则校验身份证
     */
    class func checkUserIdCard(idCard:String) ->Bool {
//        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pattern = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluateWithObject(idCard)
    }
    /**
     正则校验手机号码
     */
    class func checkTelNumber(telNumber:String) ->Bool {
        let pattern = "(^(13\\d|15[^4,\\D]|17[13678]|18\\d)\\d{8}|170[^346,\\D]\\d{7})$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluateWithObject(telNumber)
    }
    
    /**
     调试使用,打印方法调用时长
     - parameter f: 调用的方法
     */
    class func measure(f: ()->()) {
        let start = CACurrentMediaTime()
        f()
        let end = CACurrentMediaTime()
        ZQLog("所用时间：\(end - start)")
    }
    
    
    
    /**
     相册授权确认
     //        Restricted    //这个应用程序未被授权访问照片数据。
     //        Denied        //用户已经明确否认了这个应用程序访问图片数据。
     //        Authorized    //用户授权此应用程序访问图片数据。
     */
    class func isPhotoAlbumAuthorized() ->Bool {
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        ZQLog(authorization.rawValue)
        if authorization == .Denied {
            return false
        }
        
        return true
    }
    
    /**
     相册未授权(未提示用户授权)
    //        NotDetermined //用户尚未选择关于这个应用程序
     */
    class func isPhotoAlbumNotDetermined() ->Bool {
        let authorization = PHPhotoLibrary.authorizationStatus()
        if authorization == .Denied {
            return false
        }
        
        return true
    }
    
    /**
     相机授权确认
     */
    class func isCameraAuthorized() ->Bool {
        
        let authorization = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        ZQLog(authorization.rawValue)
        if authorization == .Denied {
            return false
        }
        return true
    }
    
    class func isCameraNotDetermined() ->Bool {
        let authorization = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        if authorization == AVAuthorizationStatus.Restricted {
            return false
        }
        
        return true
    }
    
    /**
     *  GCD 延时调用封装
     */
    typealias Task = ((cancel : Bool) ->())
    class func dispatch_delay(time:NSTimeInterval,task:(()->())) -> Task? {
        
        func dispatch_later(block:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(time * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(),
                block)
        }
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        
        return result
    }
    
    class func dispatch_delay_cancel(task:Task?) {
        task?(cancel:true)
    }
    
}
