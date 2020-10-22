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
    
    @IBOutlet weak var name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let currentName = defaults.string(forKey: "name"){
            name.text = currentName
        }
        self.imgProfile.makeRounded()
        bios.text = "Hello i'm ihwan from majalengka. i love mobile programming."
        
    }
    
    @IBAction func editProfileClicked(_ sender: Any) {

        let dialogMessage = UIAlertController(title: "Edit Name", message: "Do you want to change your name?", preferredStyle: .alert)

        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Masukan Nama Baru"
        })

        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.name.text = "\(dialogMessage.textFields?.first?.text ?? "Ihwan D")"
            let defaults = UserDefaults.standard
            defaults.set("\(dialogMessage.textFields?.first?.text ?? "Ihwan D")", forKey: "name")
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }

        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)


        self.present(dialogMessage, animated: true, completion: nil)
    }

    @IBAction func tweetClicked(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://twitter.com/Ihwan_ID")!)
        present(vc, animated: true)
    }
}
