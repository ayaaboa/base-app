//
//  Config.swift
//  MIBand
//
//  Created by 陈亚勃 on 2018/6/21.
//  Copyright © 2018年 陈亚勃. All rights reserved.
//

import UIKit
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

func kDeviceScale(num:CGFloat) ->CGFloat{
    return num*ScreenWidth/375
}

