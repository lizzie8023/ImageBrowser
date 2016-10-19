//
//  UIBarButtonItem+Extension.swift
//  weibo
//
//  Created by 风晓得8023 on 15/10/10.
//  Copyright © 2015年 诠释. All rights reserved.
//  设置所有导航栏Item的样式

import Foundation
import UIKit

enum ItemType {
    case Left
    case Right
}

extension UIBarButtonItem {
    
    
    class func customItem (view: UIView) ->UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
}