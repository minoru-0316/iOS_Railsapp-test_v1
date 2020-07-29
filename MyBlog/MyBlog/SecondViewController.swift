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
    

    

    
    //    Titleを格納するプロパティ
    var titleText: String?
    var idText: Int?
    var createdAtText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SecondTitleLabel.text = self.titleText
        self.SecondIdLabel.text = "投稿ID: \(self.idText)"
        self.SecondCreatedAtLabel.text = self.createdAtText
    }
    
}
