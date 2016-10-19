//
//  UITextField+Extension.swift
//  New
//
//  Created by 张泉 on 16/3/5.
//  Copyright © 2016年 Tuofeng. All rights reserved.
//

import UIKit


extension UITextField {

    /**
     快捷创建一个金额键盘
     - parameter fontSize:    字体大小
     - parameter placeholder: 占位字符
     */
    class func sumKeyboard(fontSize fontSize:CGFloat, placeholder:String?, textColor:UIColor?,textAlignment:NSTextAlignment) ->UITextField {
        
        let textField = UITextField()
        textField.textAlignment = textAlignment
        textField.font = UIFont.systemFontOfSize(fontSize)
        textField.textColor = textColor
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        textField.placeholder = placeholder ?? ""
        if textColor != nil {
            textField.textColor = textColor
        }
        return textField
    }
}