import UIKit
import Firebase
import FirebaseStorage


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    
    @IBOutlet weak var loginSegmentView: UIView!
    
    @IBOutlet weak var registerSegmentView: UIView!
    
    
    
    var iconClick = false
    let imageicon = UIImageView()
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(loginSegmentView)
        
        let imageView = UIImageView(frame: CGRect(x: 100, y: 180, width: 200, height: 200)) // Örnek bir frame
           imageView.image = UIImage(named: "girişEkranı") // Kendi resminin adını ekle
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.layer.cornerRadius = imageView.frame.size.width / 3.3 // Yuvarlaklığı belirle
           self.view.addSubview(imageView)
        
        
     
        
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            self.view.bringSubviewToFront(loginSegmentView)
        case 1 :
            self.view.bringSubviewToFront(registerSegmentView)
        default:
            break
        }
    }
    
    
}
            
            
            
           
        
        
    
