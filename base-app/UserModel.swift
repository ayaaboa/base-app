//
//  UserModel.swift
//  base-app
//
//  Created by 陈亚勃 on 2018/7/5.
//  Copyright © 2018年 陈亚勃. All rights reserved.
//


struct UserModel : Codable{
    let isSuccess : Bool?
    let data : ResultData?

    struct ResultData:Codable {

    }

    enum CodingKeys:String, CodingKey {
        case isSuccess = "success"
        case data
        
    }
}




