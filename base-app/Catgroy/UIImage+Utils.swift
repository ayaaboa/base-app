//
//  Image+Utils.swift
//  jsonToModel
//
//  Created by 陈亚勃 on 2018/7/4.
//  Copyright © 2018年 陈亚勃. All rights reserved.
//

import UIKit
extension UIImage{
    func compressImage(sizeScale : CGFloat, qualityScale : CGFloat) -> UIImage{
        let newSize = CGSize(width: self.size.width*sizeScale, height: self.size.height*sizeScale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, qualityScale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
