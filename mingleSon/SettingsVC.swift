//
//  SettingsVC.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 2.01.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "A") // Kendi resminin adını ekle
        backgroundImage.contentMode = .scaleAspectFill // İstediğin ölçekte görüntülemek için uygun olanı seç
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
    }
    


    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch {
            print("error")
            
        }
        
        
    }
}
