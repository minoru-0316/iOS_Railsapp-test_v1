//
//  LoginViewController.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/07/27.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailTextField.delegate=self
        userPasswordTextField.delegate=self
        
        // Do any additional setup after loading the view.
    }
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true)
    }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        print("00000")
        print(userEmail)
        print(userPassword)
        
        //入力漏れがある場合
        if(userPassword == "" || userPassword == "") {
            //アラートメッセージ
            displayMyAlertMessage(userMessage: "すべての項目を埋めてください。")
            return
        }
        
        var params: [String: Any] = [:]
        
        if let mailTextFieldStr:String = userEmailTextField.text{
            params["email"] = mailTextFieldStr
            print("---email-------")
            print(params)
        }
        if let userPasswordtextFieldStr:String = userPasswordTextField.text{
            params["password"] = userPasswordtextFieldStr
            print("---password-------")
            print(params)
        }
        
        //サーバーへPOSTする
        let urlString = "http://localhost:3000/auth/sign_in"
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
        
        //ログイン完了のアラート
        let myAlert = UIAlertController(title: "Alert", message: "ログインしました。", preferredStyle: UIAlertController.Style.alert)
        
        //ログインしたら、一覧ページへ遷移する
        self.present(myAlert, animated: true, completion: {
            self.performSegue(withIdentifier: "toNext", sender: nil)
            
        }
        )
    }
    
    func displayMyAlertMessage(userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction);
        self.present(myAlert,animated: true, completion: nil)
    }
    
    
    //新規ユーザー登録ページへ移動
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
}
