//
//  SceneDelegate.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/05/27.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        let url = URL(string: "http://localhost:3000/api/v1/posts")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse {
                
//                // HTTPヘッダの取得
//                print("HTTPヘッダの取得----------------")
//                print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
//                print("Content-Type: \(response.allHeaderFields)")
                // HTTPステータスコードの取得
                print("HTTPステータスコードの取得----------------")
                print("statusCode: \(response.statusCode)")
//                print(String(data: data, encoding: String.Encoding.utf8) ?? "")
//                print("statusCode: \(response)")
                
                let launchedBefore = UserDefaults.standard.string(forKey: "access-token")
                let statusCode = response.statusCode
                
                // 初回起動ではない場合(access-tokenが存在し、且つ有効期間が切れてない)は、一覧画面に遷移する
                DispatchQueue.main.async {
                    if(launchedBefore != nil && statusCode == 200) {
                        print("access-token--------")
                        print(launchedBefore)
                    } else {
                        
                        self.window = UIWindow(windowScene: scene as! UIWindowScene)
                        if let window = self.window {
                            // 表示
                            window.makeKeyAndVisible()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let loginVC = storyboard.instantiateViewController(withIdentifier: "login")as! LoginViewController
                            window.rootViewController = loginVC
                        }
                        print("アクセストークンがない又は有効期限切れ")
                    }
                }
            }
        }.resume()
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}



