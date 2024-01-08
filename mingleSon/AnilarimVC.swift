//
//  AnilarimVC.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 7.01.2024.
//

import UIKit
import Firebase
import FirebaseStorage


class AnilarimVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kitapAdıText: UITextField!
    @IBOutlet weak var kitapOzetText: UITextField!
    @IBOutlet weak var sayfaText: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "A") // Kendi resminin adını ekle
        backgroundImage.contentMode = .scaleAspectFill // İstediğin ölçekte görüntülemek için uygun olanı seç
        self.view.insertSubview(backgroundImage, at: 0)
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage)) // resmi tıklanabilir hale getirmek için
        imageView.addGestureRecognizer(gestureRecognizer)
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
        
        let mediaFolder = storageReference.child("memorieMedia") //media klasörüne ulaşıcam - klasörün referansı
        
        
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
                            
                            let fireStorePost = ["imageUrl" : imageUrl!, "postedBy" : "Yaptığım Anı","postBy" : Auth.auth().currentUser!.email! as Any, "postName" : self.kitapAdıText.text!, "postComment" : self.kitapOzetText.text!, "postNumber" : self.sayfaText.text!, "date" : FieldValue.serverTimestamp(),  ] as [String : Any] // alacağım ve göstereceğim veriler
                            
                            firestoreReference = firestoreDatabase.collection("Memories").addDocument(data: fireStorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    self.imageView.image = UIImage(named: "addMemories")// kullanıcı tekrar yükleme ekranına geçince o kısmı boş görmesi için
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
}

