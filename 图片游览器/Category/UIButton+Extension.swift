//
//  UIButton+Extension.swift
//  New
//
//  Created by 风晓得8023 on 15/11/14.
//  Copyright © 2015年 Tuofeng. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     便捷方法创建按钮(图片文字左右平行)
     - parameter title:     文字
     - parameter fontSize:  字体大小
     - parameter color:     颜色
     - parameter backColor: 背景色
     */
    convenience init(title: String, fontSize: CGFloat = 12, color: UIColor = UIColor.darkGrayColor(), backColor: UIColor = UIColor.whiteColor()) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    /**
     便捷创建一个按钮(图片在上文字在下)
     */
    class func buttonWithImageName(title: String, imageName: String, fontSize: CGFloat = 12, color: UIColor = UIColor.darkGrayColor()) ->UIButton{
        
        let btn = UIButton()
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        btn.addSubview(imageView)
        imageView.ff_AlignInner(type: ff_AlignType.TopCenter, referView: btn, size: nil, offset: CGPointZero)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(fontSize)
        titleLabel.text = title
        titleLabel.textColor = color
        btn.addSubview(titleLabel)
        
        titleLabel.ff_AlignVertical(type: ff_AlignType.BottomCenter, referView: imageView, size: nil, offset: CGPointMake(0, 12))

        return btn
    }
    
    /**
     根据文字和颜色返回一个纯色的按钮
     */
    class func createButton(title: String, backGroundColor: UIColor) -> UIButton {
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle(title, forState: .Normal)
        button.backgroundColor = backGroundColor
        button.setBackgroundImage(UIImage.imageWithColor(backGroundColor, size: CGSizeMake(10, 10)), forState: .Normal)
        return button
    }
    
    func addAnimation(durationTime: Double) {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.removedOnCompletion = true
        
        let animationZoomOut = CABasicAnimation(keyPath: "transform.scale")
        animationZoomOut.fromValue = 0
        animationZoomOut.toValue = 1.2
        animationZoomOut.duration = 3/4 * durationTime
        
        let animationZoomIn = CABasicAnimation(keyPath: "transform.scale")
        animationZoomIn.fromValue = 1.2
        animationZoomIn.toValue = 1.0
        animationZoomIn.beginTime = 3/4 * durationTime
        animationZoomIn.duration = 1/4 * durationTime
        
        groupAnimation.animations = [animationZoomOut, animationZoomIn]
        self.layer.addAnimation(groupAnimation, forKey: "addAnimation")
    }
    
    class func createButton(title title:String, fontSize:CGFloat,radius:CGFloat, titleColor:UIColor, backgroundColor:UIColor) ->UIButton {
        let button = UIButton()
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(titleColor, forState: UIControlState.Normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFontOfSize(12)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }
    
    class func createButtonWithCornerRadius(radius:CGFloat) ->UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = radius
        btn.layer.masksToBounds = true
        return btn
    }
    
}
