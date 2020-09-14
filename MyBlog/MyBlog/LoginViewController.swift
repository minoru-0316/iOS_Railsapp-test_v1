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
            
            let userDefaults = UserDefaults.standard
            userDefaults.register(defaults: ["LoginStatus": false])
            print("ユーザーデフォルト")
            print(userDefaults)
            
            
            print("入力された値を出力")
            print(userEmail as Any)
            print(userPassword as Any)
            
            //入力漏れがある場合
            if(userEmail == "" || userPassword == "") {
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
                    print("idなどが入っているresultを出力するーーーーーーー")
                    print("result:\(resultData)")
                    
                    let resultDataArray: [String] = [resultData]
                    print("--------000000--------")
                    print(resultDataArray)
                    
                    
                    DispatchQueue.main.async {
                        //statuscode、access-token、メールアドレスを取得
                        if let response = response as? HTTPURLResponse{
                            print("response: \(response)")
                            
                            
                            let statusCode = response.statusCode
                            print("ステータスコード")
                            print(statusCode)
                            if (statusCode == 401 || statusCode != 200) {
                                self.displayMyAlertMessage(userMessage: "ログイン情報が正しくありません。")
                                print("ログインエラーです")
                                return
                            }
                                //                        else if(statusCode == 200){
                                //                            self.performSegue(withIdentifier: "secondSegue", sender: nil)
                                //                            self.performSegue(withIdentifier: "loginsucceed", sender: nil)
                                //                        }
                                //                        userDefaults.set(true, forKey: "LoginStatus")
                                
                            else if(statusCode == 200){
                                let accessToken = (response.allHeaderFields["access-token"] as? String)!
                                print("access-token取得")
                                print(accessToken)
                                
                                let client = (response.allHeaderFields["client"] as? String)!
                                print("client取得")
                                print(client)
                                
                                let userEmail = (response.allHeaderFields["uid"] as? String)!
                                print("メアド取得（uid）")
                                print(userEmail)
                                
                                
                                userDefaults.set(accessToken, forKey: "access-token")
                                userDefaults.set(userEmail, forKey: "uid")
                                print("ログインしました")
                                print(userDefaults)
                                
                                
                                let loginStatus = userDefaults.bool(forKey: "LoginStatus")
                                print("loginStatus-------------")
                                print(loginStatus)
                                print("responseの中身全部------------")
                                print(response.allHeaderFields)
                                
                                let nextVC = self.storyboard?.instantiateViewController(identifier: "topPage")
                                self.present(nextVC!, animated: true, completion: nil)
                            }
                        }
                    }
                })
                task.resume()
                
                
            }catch{
                print("Error:\(error)")
                displayMyAlertMessage(userMessage: "ログイン情報が正しくありません。")
                return
            }
            
            //ログイン完了のアラート
            //            let myAlert = UIAlertController(title: "Alert", message: "ログインしました。", preferredStyle: UIAlertController.Style.alert)
            
            //ログインしたら、一覧ページへ遷移する
            //これがあると、検索が機能しなくなるのでコメントアウトした。
            //        self.present(myAlert, animated: true, completion: {
            //            self.performSegue(withIdentifier: "toNext", sender: nil)
            //
            //        }
            //        )
            
            
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
