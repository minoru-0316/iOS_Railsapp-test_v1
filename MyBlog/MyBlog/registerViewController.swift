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
    

    @IBAction func registerBtnTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        
        print("00000")
        print(userEmail)
        print(userPassword)
        print(repeatPassword)
        
        func alert(title:String, message:String) {
            alertController = UIAlertController(title: title, message:  message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
        
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
        
        
        

    //メッセージアラートの設定
    let myAlert = UIAlertController(title:"Alert", message: "登録完了です！", preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default){
        action in self.dismiss(animated: true, completion: nil)
    }
    myAlert.addAction(okAction)
    self.present(myAlert, animated:true, completion: nil)
    }
    
    func displayMyAlertMessage(userMessage: String){
        
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction);
        self.present(myAlert,animated: true, completion: nil)
    }
}
