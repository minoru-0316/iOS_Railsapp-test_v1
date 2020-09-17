//
//  SecondViewController.swift
//  MyBlog
//
//  Created by Minoru Edo on 2020/06/11.
//  Copyright © 2020 Minoru Edo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var SecondTitleLabel: UILabel!
    @IBOutlet weak var SecondIdLabel: UILabel!
    @IBOutlet weak var SecondCreatedAtLabel: UILabel!
    @IBOutlet weak var SecondUserIdLabel: UILabel!
    
    
    
    
    
    //    Titleを格納するプロパティ
    var titleText: String?
    var idText: Int?
    var createdAtText: String?
    var userIdText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SecondTitleLabel.text = self.titleText
        self.SecondIdLabel.text = "投稿ID: \(String(describing: self.idText))"
        self.SecondCreatedAtLabel.text = self.createdAtText
        self.SecondUserIdLabel.text = self.userIdText
        
    }
    
}
