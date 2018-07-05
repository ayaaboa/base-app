//
//  ProgressHUD.swift
//  MIBand
//
//  Created by 陈亚勃 on 2018/6/21.
//  Copyright © 2018年 陈亚勃. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import SDWebImage

let HUD_SCREEN_WIDTH = UIScreen.main.bounds.size.width

let hideDelay:TimeInterval = 1.5
let hudMinSize = CGSize(width: 100.0, height: 100.0)

class ProgressHUD: NSObject {
    
    static let shareHUD = ProgressHUD()
    let hud = MBProgressHUD.init()
    
    override init() {
        super.init()
        hud.minSize = hudMinSize
        hud.delegate = self
        hud.removeFromSuperViewOnHide = true
        hud.label.numberOfLines = 0
        hud.margin = 10
    }
    
    class func showOnView(view:UIView){
        shareHUD.hud.mode = .indeterminate
        view.addSubview(shareHUD.hud)
        shareHUD.hud.show(animated: true)
    }
    
    class func hide(){
        shareHUD.hud.hide(animated: true)
    }
    
    class func showSuccessHUD(on view:UIView){
        let imageView = UIImageView.init(image: UIImage.init(named: "hud_success"))
        shareHUD.hud.customView = imageView
        shareHUD.hud.mode = .customView
        shareHUD.hud.removeFromSuperViewOnHide = true
        view.addSubview(shareHUD.hud)
        
        shareHUD.hud.show(animated: true)
        shareHUD.hud.hide(animated: true, afterDelay: hideDelay)
    }
    
    class func showErrorHUD(on view:UIView){
        let imageView = UIImageView.init(image: UIImage.init(named: "hud_error"))
        shareHUD.hud.customView = imageView
        shareHUD.hud.mode = .customView
        view.addSubview(shareHUD.hud)
        
        shareHUD.hud.show(animated: true)
        shareHUD.hud.hide(animated: true, afterDelay: hideDelay)
    }
    
    class func showSuceessHUD(text:String ,on view:UIView){
        let imageView = UIImageView.init(image: UIImage.init(named: "hud_success"))
        shareHUD.hud.customView = imageView
        shareHUD.hud.mode = .customView
        shareHUD.hud.label.text = text
        view.addSubview(shareHUD.hud)
        
        shareHUD.hud.show(animated: true)
        shareHUD.hud.hide(animated: true, afterDelay: hideDelay)
        
    }
    
    class func showErrorHUD(text:String ,on view:UIView){
        let imageView = UIImageView.init(image: UIImage.init(named: "hud_error"))
        shareHUD.hud.customView = imageView
        shareHUD.hud.mode = .customView
        shareHUD.hud.label.text = text
        view.addSubview(shareHUD.hud)
        
        shareHUD.hud.show(animated: true)
        shareHUD.hud.hide(animated: true, afterDelay: hideDelay)
    }
    
    class func showTextHUD(text:String,on view:UIView){
        shareHUD.hud.mode = .text
        shareHUD.hud.label.text = text
        view.addSubview(shareHUD.hud)
        
        shareHUD.hud.show(animated: true)
        shareHUD.hud.hide(animated: true, afterDelay: hideDelay)
    }
    
    class func showGifHUD(on view:UIView){
        shareHUD.hud.mode = .customView
        shareHUD.hud.backgroundColor = .clear
        
        let gifImageView =  UIImageView()
        //gif不能发在Assets中
        let gifImage = UIImage.sd_animatedGIFNamed("loading")
        gifImage?.sd_animatedImageByScalingAndCropping(to: CGSize(width: 37, height: 37))
        gifImageView.image = gifImage
        shareHUD.hud.customView = gifImageView
        
        view.addSubview(shareHUD.hud)
        shareHUD.hud.show(animated: true)
    }
}

extension ProgressHUD : MBProgressHUDDelegate{
    func hudWasHidden(_ hud: MBProgressHUD) {
        hud.mode = .indeterminate
        hud.detailsLabel.text = ""
        hud.label.text = ""
    }
}




