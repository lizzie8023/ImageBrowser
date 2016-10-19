//
//  UILabel+Extension.swift
//  New
//
//  Created by 风晓得8023 on 15/10/24.
//  Copyright © 2015年 Tuofeng. All rights reserved.
//


import Foundation
import UIKit

extension UILabel {
    
    /**
     便捷的构造方法
     - parameter color:    字体颜色
     - parameter fontSize: 字体大小
     */
    convenience init(color: UIColor, fontSize: CGFloat, textAlignment:NSTextAlignment) {
        self.init()
        self.textColor = color
        self.textAlignment = textAlignment
        self.font = UIFont.systemFontOfSize(fontSize)
    }
    
    class func unitLabel(text:String,color:UIColor,fontSize:CGFloat) ->UILabel {
        
        let unitLabel = UILabel()
        unitLabel.text = text
        unitLabel.textColor = color
        unitLabel.font = UIFont.systemFontOfSize(fontSize)
        return unitLabel
    }
    
}