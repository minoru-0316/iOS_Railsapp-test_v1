//
//  ViewController.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/05/27.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchText.delegate = self
        searchText.placeholder = "キーワードを入力してください"
        tableView.dataSource = self
        tableView.delegate  = self
        
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        self.tableView.estimatedRowHeight = 100
        let launchedBefore = UserDefaults.standard.string(forKey: "access-token")
        print(launchedBefore as Any)
//        let launchedBefore2 = UserDefaults.standard.string(forKey: "uid")
//        print(launchedBefore2)        
    }
    
    
    
    
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var blogList : [(id:Int , title:String , createdAt:String , memo:String)] = []
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        print("--1111111--")
        
        if let searchWord = searchBar.text {
            print(searchWord)
            searchBlog(keyword: searchWord)
        }
    }
    
    
    
    struct ItemJson: Codable {
        let id: Int?
        let title: String?
        let created_at: String?
        let memo: String?
    }
    
    struct ResultJson: Codable {
        let data:[ItemJson]?
    }
    
    
    func searchBlog(keyword :  String){
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let req_url = URL(string:
            "http://localhost:3000/api/v1/posts/?search=\(keyword_encode)") else {
                return
        }
        print(req_url)
        
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: req, completionHandler: {
            (data , response , error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                if let items = json.data {
                    self.blogList.removeAll()
                    
                    for data in items {
                        if let title = data.title , let id = data.id , let createdAt = data.created_at, let memo = data.memo {
                            let blog = (id,title,createdAt,memo)
                            self.blogList.append(blog)
                            print("--------------")
                            print(blog)
                        }
                    }
                    self.tableView.reloadData()
                    if let blogdbg = self.blogList.first {
                        print("--------------")
                        print("blogList[0] = \(blogdbg)")
                    }
                }
            }
            catch {
                print("エラーが出ました")
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogList.count
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    ////        let cell = tableView.dequeueReusableCell(withIdentifier: "blogCell", for: indexPath)
    //        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "blogCell")
    //
    //        cell.textLabel?.text = blogList[indexPath.row].title
    //        cell.detailTextLabel?.text = "投稿ID: \(blogList[indexPath.row].id)"+"　/ 投稿日時: \(blogList[indexPath.row].createdAt)"
    //
    //        print(blogList[indexPath.row].title)
    //        print(blogList[indexPath.row].id)
    //        print(blogList[indexPath.row].createdAt)
    //
    //
    //        return cell
    //
    //        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        
        print("00000000000---------")
        print(blogList[indexPath.row].title)
        print(blogList[indexPath.row].id)
        print(blogList[indexPath.row].createdAt)
        print(blogList[indexPath.row].memo)
        
        cell.Label1?.text =  blogList[indexPath.row].title
        cell.Label2?.text =  "投稿ID: \(blogList[indexPath.row].id)"
        cell.Label3?.text =  "投稿日時" + blogList[indexPath.row].createdAt
        cell.memo?.text =  blogList[indexPath.row].memo
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        print("aaaaaaa")
        
        let titleText = blogList[indexPath.row].title
        let idText = blogList[indexPath.row].id
        let createdAtText = blogList[indexPath.row].createdAt
        let memoText = blogList[indexPath.row].memo
        
        
        //      let blogData = blogList[indexPath.row]
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //【次の画面へ値を渡す】
        // 構造体
        let item :ItemJson = ItemJson(
            id: idText,
            title: titleText,
            created_at: createdAtText,
            memo: memoText
        )
        // 別の画面に遷移
        self.performSegue(withIdentifier: "SecondViewController", sender: item)
        print(titleText,idText,createdAtText)
        print("--------------")
        //        print(blogList[indexPath.row])
    }
    /// 画面遷移イベントをフックする
    /// - Parameters:
    ///   - segue: segue
    ///   - sender: パラメータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondViewController = segue.destination as? SecondViewController {
            
            if let paramater: ItemJson = sender as? ItemJson {
                // 複数のパラメータがある場合は、一つずつ渡してあげる
                secondViewController.titleText = paramater.title
                secondViewController.idText = paramater.id
                secondViewController.createdAtText = paramater.created_at
            }
        }
    }
    
    
    
    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "ThirdViewController", sender: nil)
        
    }
    
    
}




