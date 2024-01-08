//
//  GezdigimYerVC.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 3.01.2024.
//

import UIKit

class GezdigimYerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "A") // Kendi resminin adını ekle
        backgroundImage.contentMode = .scaleAspectFill // İstediğin ölçekte görüntülemek için uygun olanı seç
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
