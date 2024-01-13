//
//  UploadVC.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 2.01.2024.
//

import UIKit

class UploadVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "renkli") // Kendi resminin adını ekle
        //backgroundImage.contentMode = .scaleAspectFill // İstediğin ölçekte görüntülemek için uygun olanı seç
        self.view.insertSubview(backgroundImage, at: 0)
        
        let imageView5 = UIImageView(frame: CGRect(x: 62, y: 111, width: 110, height: 110)) // Örnek bir frame
        imageView5.image = UIImage(named: "anılarım") // Kendi resminin adını ekle
        imageView5.contentMode = .scaleAspectFill
        imageView5.clipsToBounds = true
        imageView5.layer.cornerRadius = imageView5.frame.size.width / 2 // Yuvarlaklığı belirle
        self.view.addSubview(imageView5)
            
        let imageView1 = UIImageView(frame: CGRect(x: 62, y: 285, width: 110, height: 110)) // Örnek bir frame
        imageView1.image = UIImage(named: "gezdigimyerler") // Kendi resminin adını ekle
        imageView1.contentMode = .scaleAspectFill
        imageView1.clipsToBounds = true
        imageView1.layer.cornerRadius = imageView1.frame.size.width / 2 // Yuvarlaklığı belirle
        imageView1.layer.cornerRadius = imageView1.frame.size.height / 2
        self.view.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: CGRect(x: 62, y: 465, width: 110, height: 110)) // Örnek bir frame
        imageView2.image = UIImage(named: "okudugumkitaplar") // Kendi resminin adını ekle
        imageView2.contentMode = .scaleAspectFill
        imageView2.clipsToBounds = true
        imageView2.layer.cornerRadius = imageView2.frame.size.width / 2 // Yuvarlaklığı belirle
        self.view.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: CGRect(x: 62, y: 640, width: 110, height: 110)) // Örnek bir frame
        imageView3.image = UIImage(named: "izledigimfilmler") // Kendi resminin adını ekle
        imageView3.contentMode = .scaleAspectFill
        imageView3.clipsToBounds = true
        imageView3.layer.cornerRadius = imageView3.frame.size.width / 2 // Yuvarlaklığı belirle
        self.view.addSubview(imageView3)
        
      

    }
    


}
