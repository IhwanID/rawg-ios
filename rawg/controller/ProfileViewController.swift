//
//  ProfileViewController.swift
//  rawg
//
//  Created by Ihwan ID on 28/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var bios: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgProfile.makeRounded()
        bios.text = "Hello i'm ihwan from majalengka. i love mobile programming."
        
    }
    
    
    @IBAction func tweetClicked(_ sender: Any) {
        print("something")
        let vc = SFSafariViewController(url: URL(string: "https://twitter.com/Ihwan_ID")!)
        present(vc, animated: true)
    }
}
