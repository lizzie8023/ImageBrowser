//
//  UIView+Extension.swift
//  weibo
//
//  Created by 风晓得8023 on 15/10/9.
//  Copyright © 2015年 诠释. All rights reserved.
//  UIView的分类,用来扩展直接点出对应的frame参数进行修改

import Foundation
import UIKit

extension UIView {
        
        var width: CGFloat {
            get{
                return self.frame.width
            }
            set{
                var frame = self.frame
                frame.size.width = newValue
                self.frame = frame
            }
        }
        
        var height: CGFloat {
            get{
                return self.frame.height
            }
            set{
                var frame = self.frame
                frame.size.height = newValue
                self.frame = frame
            }
        }
    
        var x: CGFloat {
            get{
                return self.frame.origin.x
            }
            set{
                var frame = self.frame
                frame.origin.x = newValue
                self.frame = frame
            }
        }
        
        var y: CGFloat {
            get{
                return self.frame.origin.y
            }
            set{
                var frame = self.frame
                frame.origin.y = newValue
                self.frame = frame
            }
        }
        
        var centerX: CGFloat {
            get{
                return self.center.x
            }
            set{
                var center = self.center
                center.x = newValue
                self.center = center
            }
        }
        
        var centerY: CGFloat {
            get{
                return self.center.y
            }
            set{
                var center = self.center
                center.y = newValue
                self.center = center
            }
        }
    
        var size: CGSize {
            get{
                return self.frame.size
            }
            set{
                var frame = self.frame
                frame.size = newValue
                self.frame = frame
            }
        }
    
    class func lineView() ->UIView {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithString("#E5E5E5")
        return view
    }
    
    class func viewWithColor(color color:UIColor) ->UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}
