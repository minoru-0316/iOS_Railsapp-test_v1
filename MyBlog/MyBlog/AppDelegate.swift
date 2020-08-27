//
//  AppDelegate.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/05/27.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        //使用するStoryBoardのインスタンス化
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let url = URL(string: "http://localhost:3000/auth/validate_token")
//        let request = URLRequest(url: url!)
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if error == nil, let data = data, let response = response as? HTTPURLResponse {
//
//                // HTTPヘッダの取得
//                print("HTTPヘッダの取得----------------")
//                print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
//                print("Content-Type: \(response.allHeaderFields)")
//                // HTTPステータスコードの取得
//                print("HTTPステータスコードの取得----------------")
//                print("statusCode: \(response.statusCode)")
//                print(String(data: data, encoding: String.Encoding.utf8) ?? "")
//                print("statusCode: \(response)")
//
//                //                // UserDefaultsにString型のKey"launchedBefore"を用意
//                //                let launchedBefore = UserDefaults.standard.string(forKey: "access-token")
//                //                print("launchedBeforeに入れたaccess-tokenの確認")
//                //                print("launchedBefore: \(launchedBefore)")
//
//                //                DispatchQueue.main.async {
//                //                    // 初回起動ではない場合は、一覧画面に遷移する
//                //この処理は、iOS13以降は、SceneDelegate.swiftファイルに記載する。
//                //                    if(launchedBefore != nil) {
//                //                        print("初回起動でない場合: \(launchedBefore)")
//                //                    } else {
//                //                        //起動を判定するlaunchedBeforeという論理型のKeyをUserDefaultsに用意
//                ////                                                UserDefaults.standard.set(true, forKey: "accessToken")
//                //
//                //                        let loginVC = storyboard.instantiateViewController(withIdentifier: "login")as! LoginViewController
//                //                        print(loginVC)
//                //                        self.window = UIWindow(frame: UIScreen.main.bounds)
//                //                        self.window?.rootViewController = loginVC
//                //
//                //                        print("アクセストークンがない")
//                //                    }
//                //                }
//            }
//        }
//        .resume()
        return true
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

