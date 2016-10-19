//
//  UIColor+Extension.swift
//  New
//
//  Created by 风晓得8023 on 15/11/14.
//  Copyright © 2015年 Tuofeng. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorWithHexString (hex: String) -> UIColor {
        var cString: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    /**
     根据色值返回RGB颜色
     
     - parameter hex: 色值
     - returns: RGB颜色
     */
    class func colorWithString(hex:String) ->UIColor{
        
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.utf16.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func rgb(r r: CGFloat,g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /**
     随机颜色
     */
    class func randomColor() -> UIColor {
        return rgb(r: CGFloat(random() % 255), g: CGFloat(random() % 255), b: CGFloat(random() % 255), a: 1)
    }
    
    class func randomColorForTopSearch() ->UIColor{
        
        switch arc4random_uniform(3) {
        case 0:
            return UIColor.rgb(r: 255, g: 49, b: 33 , a: 0.6)
        case 1:
            return UIColor.rgb(r: 57, g: 217, b: 174, a: 0.6)
        case 2:
            return UIColor.rgb(r: 255, g: 112, b: 9, a: 0.6)
        default:break
        }
        return UIColor.rgb(r: 255, g: 49, b: 33 , a: 0.6)
    }
}

