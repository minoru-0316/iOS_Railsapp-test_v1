//
//  registerViewController.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/07/29.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//

import UIKit

class registerViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    var alertController: UIAlertController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailTextField.delegate=self
        userPasswordTextField.delegate=self
        repeatPasswordTextField.delegate=self
        
    }
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        
        print("00000")
        print(userEmail)
        print(userPassword)
        print(repeatPassword)
        
        
        
        //入力漏れがある場合
        if(userEmail == "" || userPassword == "" || repeatPassword == ""){
            //アラートメッセージ
            displayMyAlertMessage(userMessage:  "すべての項目を埋めてください。")
            return
        }
        
        //パスワード一致確認
        if(userPassword != repeatPassword)
        {
            displayMyAlertMessage(userMessage: "パスワードが一致していません。")
            return
        }
        
        // 新規ユーザーデータ登録
        
        // まずPOSTで送信したい情報をセット。
        var params: [String: Any] = [:]
        
        if let mailTextFieldStr:String = userEmailTextField.text{
            params["email"] = mailTextFieldStr
            print("---email-------")
            print(params)
        }
        if let userPasswordTextFieldStr:String = userPasswordTextField.text{
            params["password"] = userPasswordTextFieldStr
            print("---password-------")
            print(params)
        }
        if let repeatPasswordTextFieldStr:String = repeatPasswordTextField.text{
            params["password_confirmation"] = repeatPasswordTextFieldStr
            print("---password_confirmation-------")
            print(params)
        }
        
        //参考URL-1: https://qiita.com/zakiyamaaaaa/items/4ccee2276d059dde23db
        
        let urlString = "http://localhost:3000/auth"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
                let resultData = String(data: data!, encoding: .utf8)!
                print("result:\(resultData)")
                
            })
            
            task.resume()
        }catch{
            print("Error:\(error)")
            return
        }
        
        //登録完了のアラート
        let myAlert = UIAlertController(title:"Alert", message: "ようこそ！登録完了です！", preferredStyle: UIAlertController.Style.alert)
        
        //ログインしたら、一覧ページへ遷移する
        self.present(myAlert, animated: true, completion: {
            self.performSegue(withIdentifier: "toNext", sender: nil)
            
        }
        )
    }
    
    func displayMyAlertMessage(userMessage: String){
        
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction);
        self.present(myAlert,animated: true, completion: nil)
    }
}
