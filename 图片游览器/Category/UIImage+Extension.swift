//
//  UIImage+Extension.swift
//  weibo
//
//  Created by 风晓得8023 on 15/10/10.
//  Copyright © 2015年 诠释. All rights reserved.
//

import Foundation
import UIKit
import Accelerate

extension UIImage {
    
    /**
     缩放图片
     
     - parameter image:  原始图片
     - parameter resize: 指定的压缩大小
     */
    class func reSizeImage(image:UIImage, resize:CGSize) ->UIImage {
        UIGraphicsBeginImageContext(resize)
        UIGraphicsBeginImageContextWithOptions(resize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, resize.width, resize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    /**
     压缩图片
     */
    func resetSizeOfImageData() -> NSData {
        
        let data = UIImageJPEGRepresentation(self, 1.0)
        let length = data?.length ?? 0
        if (length / 1024) > 1024 {
            return UIImageJPEGRepresentation(self, 0.5)!
        }else {
            return data!
        }
    }
    
    /** 返回一个基于中心点的拉伸图片        */
    class func imageWithName(name:String) -> UIImage{
    
        let image = UIImage(named: name)!
        return image.stretchableImageWithLeftCapWidth(Int(image.size.width * 0.5), topCapHeight: Int(image.size.height * 0.6))
    }
    
     /**    returns: 返回一个缩放的图片   */
    func scale(width width: CGFloat) -> UIImage {
        
        // 1. 如果图像本身很小，直接返回
        if size.width < width {
            return self
        }
        // 计算目标尺寸
        let height = size.height * width / size.width
        let s = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(s)
        drawInRect(CGRect(origin: CGPointZero, size: s))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
    /**     返回纯色的背景图片        */
    class func imageWithColor(color:UIColor,size:CGSize) ->UIImage{
        
        let rect = CGRectMake(0, 0, size.height, size.width)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
     /**    将label转换为image */
    class func imageWithView(view:UIView,size:CGSize) ->UIImage {
        
        let rect = CGRectMake(0, 0, size.height, size.width)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        view.layer.renderInContext(context!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /**
     将图片转成高斯模糊
     */
    func gaussianBlur(blurAmount:CGFloat) -> UIImage {
        var blurAmountCopy = blurAmount
        //高斯模糊参数(0-1)之间，超出范围强行转成0.5
        if (blurAmountCopy < 0.0 || blurAmountCopy > 1.0) {
            blurAmountCopy = 0.5
        }
        
        var boxSize = Int(blurAmountCopy * 40)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.CGImage
        
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        
        let inProvider =  CGImageGetDataProvider(img)
        let inBitmapData =  CGDataProviderCopyData(inProvider)
        
        inBuffer.width = vImagePixelCount(CGImageGetWidth(img))
        inBuffer.height = vImagePixelCount(CGImageGetHeight(img))
        inBuffer.rowBytes = CGImageGetBytesPerRow(img)
        inBuffer.data = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        
        //手动申请内存
        let pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
        
        outBuffer.width = vImagePixelCount(CGImageGetWidth(img))
        outBuffer.height = vImagePixelCount(CGImageGetHeight(img))
        outBuffer.rowBytes = CGImageGetBytesPerRow(img)
        outBuffer.data = pixelBuffer
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if (kvImageNoError != error)
        {
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            if (kvImageNoError != error)
            {
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                                   &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                                   UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            }
        }
        
        let colorSpace =  CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrderDefault.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue).rawValue
        
        let ctx = CGBitmapContextCreate(outBuffer.data,
                                        Int(outBuffer.width),
                                        Int(outBuffer.height),
                                        8,
                                        outBuffer.rowBytes,
                                        colorSpace,
                                        bitmapInfo)
        
        let imageRef = CGBitmapContextCreateImage(ctx)
        
        //手动申请内存
        free(pixelBuffer)
        
        return UIImage(CGImage:imageRef!)
    }
    
}
