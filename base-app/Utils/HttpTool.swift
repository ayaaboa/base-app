//
//  HttpTool.swift
//  jsonToModel
//
//  Created by 陈亚勃 on 2018/6/28.
//  Copyright © 2018年 陈亚勃. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum HttpToolResult {
    case success(JSON)
    case successWithErrorMessage(String)
    case failure(Error)
}




class HttpTool: NSObject {
   
    let baseUrl = "http://lbs-app-backend-dev.obaymax.com"
    let debugPrintEnable = true
    
    static let share = HttpTool()
    private override init(){
        self.httpHeader = ["Content-Type":"application/json"]
    }
    
    private var httpHeader:[String:String]
    
    
    class func updateHttpHeader(_ httpHeaderDic:[String:String])->Void{
        for key in httpHeaderDic.keys {
            share.httpHeader.updateValue(httpHeaderDic[key] ?? "", forKey: key)
        }
    }
    
    
    class func post(url:String, param:[String:Any],result:@escaping (_ result:HttpToolResult)->Void){
        
        Alamofire.request(share.baseUrl+url,
                          method: .post,
                          parameters: param,
                          encoding: JSONEncoding.default,
                          headers: share.httpHeader)
            .responseJSON { (response) in
                if share.debugPrintEnable == true{
                    share.httpDebugPrint(response: response)
                }
                switch response.result{
                case .success(let json):
                    let jsonObj = JSON(json)
                    if jsonObj["code"] == 0{
                        result(.success(jsonObj))
                    }else{
                        let str = jsonObj["errMsg"].rawString()!
                        result(.successWithErrorMessage(str))
                    }
                case .failure(let error):
                    result(.failure(error))
                }
            }
    }
    
    class func get(url:String,param:[String:Any],result:@escaping (_ result:HttpToolResult)->Void){
        Alamofire.request(share.baseUrl+url,
                          method: .get,
                          parameters: param,
                          encoding: JSONEncoding.default,
                          headers: share.httpHeader)
            .responseJSON { (response) in
                if share.debugPrintEnable == true{
                    share.httpDebugPrint(response: response)
                }
                switch response.result{
                case .success(let json):
                    let jsonObj = JSON(json)
                    if jsonObj["code"] == 0{
                        result(.success(jsonObj))
                    }else{
                        let str = jsonObj["errMsg"].rawString()!
                        result(.successWithErrorMessage(str))
                    }
                case .failure(let error):
                    result(.failure(error))
                }
        }
    }
    
    class func uploadImage(image:UIImage,result:@escaping (_ result:HttpToolResult)->Void){
        let url = share.baseUrl+"/file/uploadImage"
        
        let compressImage = image.compressImage(sizeScale: 0.7, qualityScale: 0.7)
//        let imageData = UIImagePNGRepresentation(compressImage)
        let imageData = compressImage.pngData()
        
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(imageData!, withName: "file", fileName: "image.png", mimeType: "image/png")
        }, to: url) { (encodingResult) in
            
            switch encodingResult{
            case .success(let uploadRequest,_,_):
                uploadRequest.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                
                uploadRequest.responseJSON(completionHandler: { (response) in
                    if share.debugPrintEnable == true{
                        share.httpDebugPrint(response: response)
                    }
                    switch response.result{
                    case .success(let json):
                        let jsonObj = JSON(json)
                        if jsonObj["code"] == 0{
                            result(.success(jsonObj))
                        }else{
                            let str = jsonObj["errMsg"].rawString()!
                            result(.successWithErrorMessage(str))
                        }
                    case .failure(let error):
                        result(.failure(error))
                    }
                })
                
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    private func httpDebugPrint(response : DataResponse<Any>){
        let url : String = response.request?.url?.description ?? ""
        do {
            var param:Any?
            if let body = response.request?.httpBody {
                param = try JSONSerialization.jsonObject(with: (body) , options: .mutableContainers)
            }
            let result = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves)
            print("url:\(url) \nparam:\(String(describing: param))\nresult:\(result)")
        } catch{
            
        }
    }
    
    
}


