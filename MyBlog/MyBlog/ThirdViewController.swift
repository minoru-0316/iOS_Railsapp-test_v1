//
//  ThirdViewController.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/06/22.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//



import Foundation
import UIKit
import SwiftyJSON


class ThirdViewController:  UIViewController, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThirdTxtFIeld.delegate = self
        print("新規投稿画面が開いた")
    }
    

    @IBOutlet weak var ThirdTxtFIeld: UITextField!
    
    
    
    @IBAction func ThirdCreateBtn(_ sender: Any) {
        
        // まずPOSTで送信したい情報をセット。
//        let textFieldStr = ThirdTxtFIeld.text!
        if let textFieldStr:String = ThirdTxtFIeld.text{
            
                    var params: [String: Any] = [:]
                    params["title"] = textFieldStr
                    print("000000")
                    print(params)
                    
            //参考URL-1: https://qiita.com/zakiyamaaaaa/items/4ccee2276d059dde23db
                    
                            let urlString = "http://localhost:3000/api/v1/posts"
                            let request = NSMutableURLRequest(url: URL(string: urlString)!)


                            request.httpMethod = "POST"
                            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                            do {
                                
                                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                                
                                let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
                                    let resultData = String(data: data!, encoding: .utf8)!
                                    print("result:\(resultData)")
            //                        print("response:\(response)")

                                })
                                //            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                            task.resume()
                                }catch{
                                    print("Error:\(error)")
                                    return
                                }
                    
                    //ひとつ前の画面に戻る処理
                    self.navigationController?.popViewController(animated: true)

                }

        }

}


