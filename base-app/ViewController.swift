//
//  ViewController.swift
//  base-app
//
//  Created by 陈亚勃 on 2018/7/4.
//  Copyright © 2018年 陈亚勃. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let param = ["loginName":"18940864676","password":"qqqqqq"]
        HttpTool.post(url: TestLoginUrl,
                      param: param) { (httpResult) in
                        switch httpResult{
                        case .success(let json):
                            let jsonData = json.description.data(using: .utf8)!
                            do{
                                let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                                print(model)
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .successWithErrorMessage(let msg):
                            ProgressHUD.showErrorHUD(text: msg, on: self.view)
                            ProgressHUD.hide(after: 2)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
        }
        
    }


}

