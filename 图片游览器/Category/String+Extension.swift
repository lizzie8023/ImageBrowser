//
//  String+Extension.swift
//  New
//
//  Created by 风晓得8023 on 15/10/24.
//  Copyright © 2015年 Tuofeng. All rights reserved.
//  根据字体转换成size

import Foundation
import UIKit

enum TFSTRINGLOCATIONTYPE:String {
    case HEAD
    case FOOT
}

extension NSString {
    
    func stringWidthFont(font: UIFont) -> CGFloat {
        if self.length < 1 {
            return 0.0
        }
        
        let size = self.boundingRectWithSize(CGSizeMake(200, 1000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return size.width ?? 0.0
    }
}

extension String {

    static func stringByX(str:String,startindex:Int,endindex:Int) -> String{
        //开始字符索引
        let startIndex = str.startIndex.advancedBy(startindex)
        //结束字符索引
        let endIndex = str.startIndex.advancedBy(endindex)
        let range = Range<String.Index>(startIndex..<endIndex)
        var s = String()
        for _ in 0..<endindex - startindex{
            s += "*"
        }
        return str.stringByReplacingCharactersInRange(range, withString: s)
    }
    
    func formattingWithString() ->NSMutableAttributedString {
        let mutableAttrStr = NSMutableAttributedString(string: self)
        mutableAttrStr.addAttributes([NSFontAttributeName:UIFont.boldSystemFontOfSize(10)], range: NSMakeRange(self.characters.count, 4))
        
        return mutableAttrStr
    }
    
    /**
     根据文本获得大小
     
     - returns: <#return value description#>
     */
    func size(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if CGSizeEqualToSize(size, CGSizeZero) {
            let attributes = [NSFontAttributeName: font]
            textSize = self.sizeWithAttributes(attributes)
        } else {
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = [NSFontAttributeName: font]
            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
    
    func contain(subStr subStr: String) -> Bool {return (self as NSString).rangeOfString(subStr).length > 0}
    
    func explode (separator: Character) -> [String] {
        return self.characters.split(isSeparator: { (element: Character) -> Bool in
            return element == separator
        }).map { String($0) }
    }
    
    func replacingOccurrencesOfString(target: String, withString: String) -> String{
        return (self as NSString).stringByReplacingOccurrencesOfString(target, withString: withString)
    }
    
    func deleteSpecialStr()->String{
        
        return self.replacingOccurrencesOfString("Optional<", withString: "").replacingOccurrencesOfString(">", withString: "")
    }
    
    var floatValue: Float? {return NSNumberFormatter().numberFromString(self)?.floatValue}
    var doubleValue: Double? {return NSNumberFormatter().numberFromString(self)?.doubleValue}
    
    func repeatTimes(times: Int) -> String{
        
        var strM = ""
        
        for _ in 0..<times {
            strM += self
        }
        
        return strM
    }
}