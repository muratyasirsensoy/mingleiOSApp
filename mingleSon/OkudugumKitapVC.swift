import UIKit
import Firebase
import FirebaseStorage


class OkudugumKitapVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var rating: Int = 0 // Kullanıcı puanı
        var starButtons = [UIButton]() // Yıldızların tutulduğu dizi
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kitapAdıText: UITextField!
    @IBOutlet weak var kitapOzetText: UITextField!
    @IBOutlet weak var sayfaText: UITextField!
    
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStarRating()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "A") // Kendi resminin adını ekle
        backgroundImage.contentMode = .scaleAspectFill // İstediğin ölçekte görüntülemek için uygun olanı seç
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage)) // resmi tıklanabilir hale getirmek için
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func createStarRating() {
            let starCount = 5
            let spacing: CGFloat = 5
            let starSize: CGFloat = 50
            var starX: CGFloat = 20
            
            for index in 0..<starCount {
                let starButton = UIButton()
                starButton.setImage(UIImage(systemName: "star"), for: .normal)
                starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
                starButton.tag = index + 1
                starButton.frame = CGRect(x: starX , y: 615, width: starSize, height: starSize)
                starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
                starX += starSize + spacing
                
                starButtons.append(starButton)
                view.addSubview(starButton)
            }
        }
        
        @objc func starButtonTapped(_ sender: UIButton) {
            guard let index = starButtons.firstIndex(of: sender) else { return }
            
            let selectedRating = index + 1 // Seçilen yıldızın pozisyonuna göre puan
            
            // Yıldızları değerlendirilen puana kadar doldur
            for i in 0..<starButtons.count {
                starButtons[i].isSelected = i < selectedRating
            }
            
            // Kullanıcının verdiği puanı sakla
            saveRatingToFirebase(rating: selectedRating)
            
            // İşlemler bittikten sonra geri bildirim veya başka işlemler yapabilirsin
            print("Kullanıcı \(selectedRating) puan verdi!")
        }
    
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }          // kullanıcı bunu seçince ne olacağının fonksiyonu

    
    func makeAlert(titleInput:String, messageInput: String) { // hata mesajı için fonksiyon oluşturdum
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference() // nereye kaydedeceiğimi
        
        let mediaFolder = storageReference.child("bookMedia") //media klasörüne ulaşıcam - klasörün referansı
        
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) { //nasıl kaydedicem - imageviewdeki görseli veriye çevirmem gerekiyor
            
            let uuid = UUID().uuidString// her görselin ismini farklı yapmak için uuid
            
        
            let imageReference = mediaFolder.child("\(uuid).jpg") // oluşturacağım görselin referansı
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    
                    imageReference.downloadURL { url, error in // kullanıcımın kaydettiği verinin hangi urlye kaydedildiğini almak için
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            //DataBase Geçiş
                            
                            let firestoreDatabase = Firestore.firestore() // database oluşturdum
                            
                            var firestoreReference : DocumentReference? = nil //Auth.auth().currentUser!.email!,
                            
                            let fireStorePost = ["imageUrl" : imageUrl!, "postedBy" : "Okuduğum Kitap","postBy" : Auth.auth().currentUser!.email! as Any ,"postName" : self.kitapAdıText.text!, "postComment" : self.kitapOzetText.text!, "postNumber" : self.sayfaText.text!, "date" : FieldValue.serverTimestamp(),   ] as [String : Any] // alacağım ve göstereceğim veriler
                            
                            firestoreReference = firestoreDatabase.collection("Memories").addDocument(data: fireStorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    self.imageView.image = UIImage(named: "addBook")// kullanıcı tekrar yükleme ekranına geçince o kısmı boş görmesi için
                                    self.kitapAdıText.text = ""
                                    self.kitapOzetText.text = ""
                                    self.sayfaText.text = ""
                                    
                                    self.tabBarController?.selectedIndex = 0 // feedVC ye geçmek için indexini kullandık
                                    
                                   
                                    
                                    
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func saveRatingToFirebase(rating: Int) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Kullanıcı oturumu bulunamadı.")
            return
        }
        
        let firestoreDatabase = Firestore.firestore()
        let ratingData = ["rating": rating]
        
        firestoreDatabase.collection("userRatings").document(currentUserID).setData(ratingData) { error in
            if let error = error {
                print("Puan kaydedilirken hata oluştu: \(error.localizedDescription)")
            } else {
                print("Puan başarıyla kaydedildi!")
            }
        }
    }

    
}
